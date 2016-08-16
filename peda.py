#!/usr/bin/python

'''
Author: Andrew Righter (@theqlabs)
Date: 2016-04-08
Purpose: An LLDB (SB API) ARM64-focused Exploit Development Assistance Plug-in based on PEDA
Usage:
	add the following to ~/.lldbinit
	command script import <path-to-peda-lldb.py>
'''

#
#	TODO:
#	Implement 'checksec' as it seems the easiest
#	

#	Feature Ideas:
#	  use symbol iteration in SBModule() to look for vulnerable functions (puts, gets, etc.)

import lldb

# Update for ARM64 (vs ARM32/Thumb) 
def isThumb(frame):
	"""
	Checks CPSR bit for ARM mode

	Copied from: upbit 'dis_capstone.py' script
	"""
	try:
		regs = frame.GetRegisters()[0]
		cpsr = [reg for reg in regs if reg.GetName()=='cpsr'][0]
		thumb_bit = int(cpsr.GetValue(), 16) & 0x20
		return thumb_bit >> 5
	except:
		return 0

def checksec(debugger, command, result, internal_dict):
	"""
	Attempts to check security features in-use:
		RELRO, NoExecute(NX), Stack Canaries, Address Space Layout Randomization (ASLR)
		and Position-Independent Executables (PIE).
	
	Based on the work by: Tobias Klein (http://www.trapkit.de/tools/checksec.html)

	"""
	
	# in a command - the lldb.* convenience variables are not to be used
	# and their values (if any) are undefined
	# this is the best practice to access those objects from within a command
	target = debugger.GetSelectedTarget()
	process = target.GetProcess()
	thread = process.GetSelectedThread()
	frame = thread.GetSelectedFrame()
	module = frame.GetModule()
	
	# Stack Canaries
	# prints symbol table (.dynsym, .symtab) looks for: __stack_check_fail
	# Command: 'image dump symtab'

	# Debug:
	print "\nTarget: %s" % target
	print "Process: %s" % process
	print "Thread: %s" % thread
	print "Frame: %s" % frame
	print "Module: %s" % module

	# TODO: module doesn't populate until after you step into exec. force it somehow?	
	for symbol in module:
		name = symbol.GetName()
		if name == '__stack_chk_fail':
			print "Canary found"

# Forces to run at load-time:
def __lldb_init_module(debugger, internal_dict):
#  file.method <cmd>
    debugger.HandleCommand('command script add -f peda.checksec checksec')
    print '\nThe "checksec" python command has been installed and is ready for use.'
