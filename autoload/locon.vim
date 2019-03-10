"
" [
"   'config-key': {
"     'generator': { default -> ... },
"     'generator_version': ,
"     'generated': 'the value',
"     'generated_version': ,
"     'default': 'default value',
"   }
" ]
"
let s:config = {}

"
" define default setting for key.
"
function! locon#def(key, default)
  if has_key(s:config, a:key)
    return
  endif
  let s:config[a:key] = { 'key': a:key, 'default': a:default }
endfunction

"
" get value.
"
function! locon#get(key)
  if has_key(s:config, a:key)
    let s:c = s:config[a:key]
    if !has_key(s:c, 'generated') || s:c['generator_version'] != s:c['generated_version']
      if has_key(s:c, 'generator')
        let s:c['generated'] = s:c['generator'](s:c['default'])
        let s:c['generated_version'] = s:c['generator_version']
      endif
    endif
    if !has_key(s:c, 'generated')
      return s:c['default']
    endif
    return s:c['generated']
  endif
  throw 'locon: key is not defined.'
endfunction

"
" set specific value.
"
function! locon#set(key, generator)
  let s:c = s:config[a:key]
  let s:c['generator'] = a:generator
  let s:c['generator_version'] = get(s:c, 'generator_version', 0) + 1
endfunction

