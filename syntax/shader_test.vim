" Language: Piglit shader test language
" Maintainer: Lyude Paul <lyude@redhat.com>

if exists("b:current_syntax")
	finish
endif

syn match   shaderTestIdentifier display contained "\h\w*"
syn keyword shaderTestBoolean    contained true false
syn keyword shaderTestTodo       contained TODO FIXME XXX NOTE
syn match   shaderTestNumber     display contained /\<\d\+\%(\.\d\+\)\?\>/
syn match   shaderTestComment    "#.*" contains=shaderTestTodo containedin=ALL

" All of the sections that can be found in a piglit shader test
" To add a new one, make sure to use the end expression:
"   end=/^\[[a-z0-9 ]\+\]$/re=s-1,he=s-1
syn keyword shaderTestExtensionAction contained enable disable
syn region shaderTestExtension matchgroup=shaderTestExtensionStart start=/^#extension / end=/$/ contains=shaderTestExtensionAction,shaderTestIdentifier

syn region shaderTestRequireSection matchgroup=shaderTestSection start="^\[require\]$" end=/^\[[a-z0-9 ]\+\]$/re=s-1,he=s-1 contains=shaderTestIdentifier,glslType,glslQualifier,shaderTestNumber
syn match shaderTestVertexShaderPassthrough display "^\[vertex shader passthrough\]$"

syn include @glsl syntax/glsl.vim

syn region shaderTestVertexData matchgroup=shaderTestSection start="^\[vertex data\]$" end=/^\[[a-z0-9 ]\+\]$/re=s-1,he=s-1 contains=shaderTestNumber,glslType,shaderTestVertexDataVar
syn match shaderTestVertexDataVar contained display "^\h\w*"

syn region shaderTestShader matchgroup=shaderTestSection start="^\[\%(vertex\|geometry\|fragment\|compute\|tessellation \%(control\|evaluation\)\) shader\]$" end=/^\[[a-z0-9 ]\+\]$/re=s-1,he=s-1 contains=@glsl

" [test] section and commands
syn region shaderTestTest matchgroup=shaderTestSection start="^\[test\]$" end=/^\[[a-z0-9 ]\+\]$/re=s-1,he=s-1 contains=glslType,glslQualifier,shaderTestNumber,shaderTestTestCommand,shaderTestTestCommandSsbo

syn match shaderTestTestCommand contained display "^atomic counters\?\%( buffer\)\?"
syn match shaderTestTestCommand contained display "^clear\%( \%(color\|depth\)\)\?"
syn match shaderTestTestCommand contained display "^clip plane"
syn match shaderTestTestCommand contained display "^compute\%( group size\)\?"
syn match shaderTestTestCommand contained display "^draw \%(rect\%( \%(patch\|tex\|ortho\%( patch\)\?\)\)\?\|instanced rect\|arrays\)"
syn match shaderTestTestCommand contained display "^\%(en\|dis\)able"
syn match shaderTestTestCommand contained display "^fb \%(draw\|read\) \%(tex \%(2d\|slice\|layered\)\|ms\|winsys\)"
syn match shaderTestTestCommand contained display "^blit \%(color\|depth\|stencil\) \%(linear\|nearest\)"
syn match shaderTestTestCommand contained display "^frustum"
syn match shaderTestTestCommand contained display "^hint"
syn match shaderTestTestCommand contained display "^image texture"
syn match shaderTestTestCommand contained display "^\%(memory\|blend\) barrier"
syn match shaderTestTestCommand contained display "^ortho"
syn match shaderTestTestCommand contained display "^probe \%(\%(\%(rect\|\%(warn \)\?all\) \)\?rgba\?\|depth\|atomic counter\|ssbo uint\)"
syn match shaderTestTestCommand contained display "^relative probe rect rgb\%(a int\)\?"
syn match shaderTestTestCommand contained display "^texture \%(rgbw\%( [12]DArray\)\?\|integer\|miptree\|checkerboard\|quads\|junk 2DArray\|storage\|shadow\%(Rect\|[12]D\%(Array\)\?\)\)"
syn match shaderTestTestCommand contained display "^tex\%(coord\|parameter\)"
syn match shaderTestTestCommand contained display "^parameter"
syn match shaderTestTestCommand contained display "^patch parameter"
syn match shaderTestTestCommand contained display "^provoking vertex"
syn match shaderTestTestCommand contained display "^link \%(error\|success\)"
syn match shaderTestTestCommand contained display "^ubo array index"
syn match shaderTestTestCommand contained display "^active uniform"
syn match shaderTestTestCommand contained display "^verify program_interface_query"
syn match shaderTestTestCommand contained display "^polygon mode"

" ssbo requires a region because things can be specified simply like ssbo 1 or
" ssbo 1 subdata float
syn region shaderTestTestCommandSsbo matchgroup=shaderTestTestCommand start="^ssbo " end=" subdata float\|$" contained oneline contains=shaderTestNumber

hi def link shaderTestBoolean                 Boolean
hi def link shaderTestNumber                  Number
hi def link shaderTestIdentifier              Identifier
hi def link shaderTestVertexShaderPassthrough Special
hi def link shaderTestSection                 Special
hi def link shaderTestVertexDataVar           Identifier
hi def link shaderTestTodo                    Todo
hi def link shaderTestComment                 Comment
hi def link shaderTestExtension               PreProc
hi def link shaderTestExtensionStart          PreProc
hi def link shaderTestExtensionAction         Boolean
hi def link shaderTestTestCommand             Function

if !exists("b:current_syntax")
	let b:current_syntax = "shader_test"
endif
