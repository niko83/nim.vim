" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Keep user-supplied options
if !exists("nim_highlight_numbers")
  let nim_highlight_numbers = 1
endif
if !exists("nim_highlight_builtins")
  let nim_highlight_builtins = 1
endif
if !exists("nim_highlight_exceptions")
  let nim_highlight_exceptions = 1
endif
if !exists("nim_highlight_space_errors")
  let nim_highlight_space_errors = 1
endif
if !exists("nim_highlight_special_vars")
  let nim_highlight_special_vars = 1
endif

if exists("nim_highlight_all")
  let nim_highlight_numbers      = 1
  let nim_highlight_builtins     = 1
  let nim_highlight_exceptions   = 1
  let nim_highlight_space_errors = 1
  let nim_highlight_special_vars = 1
endif

syn region nimBrackets       contained extend keepend matchgroup=Bold start=+\(\\\)\@<!\[+ end=+]\|$+ skip=+\\\s*$\|\(\\\)\@<!\\]+ contains=@tclCommandCluster

syn keyword nimKeyword       addr and as asm atomic
syn keyword nimKeyword       bind block 
syn keyword nimKeyword       case cast concept converter
syn keyword nimKeyword       defer discard distinct div do
syn keyword nimKeyword       end export
syn keyword nimKeyword       func
syn keyword nimKeyword       generic
syn keyword nimKeyword       include interface iterator
syn keyword nimKeyword       let var const
syn keyword nimKeyword       using mod
syn keyword nimKeyword       of out
syn keyword nimKeyword       ptr
syn keyword nimKeyword       raise ref return
syn keyword nimKeyword       shared shl shr static
syn keyword nimKeyword       try finally except 
syn keyword nimKeyword       when with without

syn keyword nimKeyword       proc nextgroup=nimFunction skipwhite 

syn keyword nimInclude       import from
syn keyword nimStatement     break continue yield assert assert
syn keyword nimClass         type method macro mixin template nextgroup=nimFunction skipwhite

" HiLink nimParameters      Normal
" HiLink nimFloat           Float
" HiLink nimDecorator       Define

syn match   nimFunction      "[a-zA-Z_][a-zA-Z0-9_]*" contained
syn match   nimClass         "[a-zA-Z_][a-zA-Z0-9_]*" contained
syn keyword nimRepeat        for in while
syn keyword nimConditional   if elif else case of
syn keyword nimOperator      and notin is isnot not or xor shl shr div
syn match   nimComment       "#.*$" contains=nimTodo,@Spell
syn region  nimComment       start="#\[" end="\]#" contains=nimTodo,@Spell
syn keyword nimTodo          TODO FIXME XXX contained


" Strings
syn region nimString start=+'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimString start=+"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimString start=+"""+ end=+"""+ keepend contains=nimEscape,nimEscapeError,@Spell
syn region nimRawString matchgroup=Normal start=+[rR]"+ end=+"+ skip=+\\\\\|\\"+ contains=@Spell

syn match  nimEscape		+\\[abfnrtv'"\\]+ contained
syn match  nimEscape		"\\\o\{1,3}" contained
syn match  nimEscape		"\\x\x\{2}" contained
syn match  nimEscape		"\(\\u\x\{4}\|\\U\x\{8}\)" contained
syn match  nimEscape		"\\$"

syn match nimEscapeError "\\x\x\=\X" display contained

if nim_highlight_numbers == 1
  " numbers (including longs and complex)
  syn match   nimNumber	"\v<0x\x+(\'(i|I|f|F|u|U)(8|16|32|64))?>"
  syn match   nimNumber	"\v<[0-9_]+(\'(i|I|f|F|u|U)(8|16|32|64))?>"
  syn match   nimNumber	"\v[0-9]\.[0-9_]+([eE][+-]=[0-9_]+)=>"
  syn match   nimNumber	"\v<[0-9_]+(\.[0-9_]+)?([eE][+-]?[0-9_]+)?(\'(f|F)(32|64))?>"
endif

if nim_highlight_builtins == 1
  " builtin functions, types and objects, not really part of the syntax
  syn keyword nimBuiltinType int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 float float32 float64 bool
  syn keyword nimBuiltinType char string cstring pointer range array openarray seq tuple 
  syn keyword nimBuiltinType set enum object 
  syn keyword nimBuiltinType Byte Natural Positive Conversion
  syn keyword nimBuiltinType BiggestInt BiggestFloat cchar cschar cshort cint csize cuchar cushort
  syn keyword nimBuiltinType clong clonglong cfloat cdouble clongdouble cuint culong culonglong cchar

  syn keyword nimBuiltinObj  true false nil
  syn keyword nimBuiltinObj  FileMode File RootObj FileHandle ByteAddress Endianness

  syn keyword nimBuiltinFunc CompileDate CompileTime nimVersion nimMajor
  syn keyword nimBuiltinFunc nimMinor nimPatch cpuEndian hostOS hostCPU inf
  syn keyword nimBuiltinFunc neginf nan QuitSuccess QuitFailure dbgLineHook stdin
  syn keyword nimBuiltinFunc stdout stderr defined new high low sizeof succ pred
  syn keyword nimBuiltinFunc inc dec newSeq len incl excl card ord chr ze ze64
  syn keyword nimBuiltinFunc toU8 toU16 toU32 abs min max add repr
  syn match   nimBuiltinFunc "\<contains\>"
  syn keyword nimBuiltinFunc toFloat toBiggestFloat toInt toBiggestInt addQuitProc
  syn keyword nimBuiltinFunc copy setLen newString zeroMem copyMem moveMem
  syn keyword nimBuiltinFunc equalMem alloc alloc0 realloc dealloc setLen
  syn keyword nimBuiltinFunc swap getRefcount getCurrentException Msg
  syn keyword nimBuiltinFunc getOccupiedMem getFreeMem getTotalMem isNil seqToPtr
  syn keyword nimBuiltinFunc find pop GC_disable GC_enable GC_fullCollect
  syn keyword nimBuiltinFunc GC_setStrategy GC_enableMarkAndSweep GC_Strategy
  syn keyword nimBuiltinFunc GC_disableMarkAnd Sweep GC_getStatistics GC_ref
  syn keyword nimBuiltinFunc GC_ref GC_ref GC_unref GC_unref GC_unref quit
  syn keyword nimBuiltinFunc OpenFile OpenFile CloseFile EndOfFile readChar
  syn keyword nimBuiltinFunc FlushFile readFile write readLine writeln writeln
  syn keyword nimBuiltinFunc getFileSize ReadBytes ReadChars readBuffer writeBytes
  syn keyword nimBuiltinFunc writeChars writeBuffer setFilePos getFilePos
  syn keyword nimBuiltinFunc fileHandle countdown countup items lines
  syn keyword nimBuiltinFunc FileMode File RootObj FileHandle ByteAddress Endianness
endif

if nim_highlight_exceptions == 1
  " builtin exceptions and warnings
  syn keyword nimException E_Base EAsynch ESynch ESystem EIO EOS
  syn keyword nimException ERessourceExhausted EArithmetic EDivByZero
  syn keyword nimException EOverflow EAccessViolation EAssertionFailed
  syn keyword nimException EControlC EInvalidValue EOutOfMemory EInvalidIndex
  syn keyword nimException EInvalidField EOutOfRange EStackOverflow
  syn keyword nimException ENoExceptionToReraise EInvalidObjectAssignment
  syn keyword nimException EInvalidObject EInvalidLibrary EInvalidKey
  syn keyword nimException EInvalidObjectConversion EFloatingPoint
  syn keyword nimException EFloatInvalidOp EFloatDivByZero EFloatOverflow
  syn keyword nimException EFloatInexact EDeadThread EResourceExhausted
  syn keyword nimException EFloatUnderflow
endif

if nim_highlight_space_errors == 1
  " trailing whitespace
  syn match   nimSpaceError   display excludenl "\S\s\+$"ms=s+1
  " any tabs are illegal in nim
  syn match   nimSpaceError   display "\t"
endif

if nim_highlight_special_vars
  syn keyword nimSpecialVar result self
endif

syn sync match nimSync grouphere NONE "):$"
syn sync maxlines=200
syn sync minlines=2000

if version >= 508 || !exists("did_nim_syn_inits")
  if version <= 508
    let did_nim_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink nimBrackets       Operator
  HiLink nimKeyword	      Keyword
  HiLink nimFunction	    	Function
  HiLink nimConditional	  Conditional
  HiLink nimRepeat		      Repeat
  HiLink nimString		      String
  HiLink nimRawString	    String
  HiLink nimBoolean        Boolean
  HiLink nimEscape		      Special
  HiLink nimOperator		    Operator
  HiLink nimPreCondit	    PreCondit
  HiLink nimComment		    Comment
  HiLink nimTodo		        Todo
  HiLink nimDecorator	    Define
  HiLink nimSpecialVar	    Identifier
  HiLink nimStatement       Statement
  HiLink nimInclude         Include
  HiLink nimClass           Type
  HiLink nimParameters      Normal
  HiLink nimFloat           Float
  
  if nim_highlight_numbers == 1
    HiLink nimNumber	Number
  endif
  
  if nim_highlight_builtins == 1
    HiLink nimBuiltinType   Type
    HiLink nimBuiltinObj    Structure
    HiLink nimBuiltinFunc   Function
  endif
  
  if nim_highlight_exceptions == 1
    HiLink nimException	Exception
  endif
  
  if nim_highlight_space_errors == 1
    HiLink nimSpaceError	Error
  endif

  delcommand HiLink
endif

let b:current_syntax = "nim"

