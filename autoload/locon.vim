"
" [{
"   'key': k,
"   'default': v or [v],
"   'current': v or [v]
" }]
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
    return get(s:config[a:key], 'current', s:config[a:key]['default'])
  endif
  throw 'locon: key is not defined.'
endfunction

"
" set specific value.
"
function! locon#set(key, fn)
  if has_key(s:config, a:key)
    let s:config[a:key]['current'] = a:fn(deepcopy(s:config[a:key]['default']))
    return
  endif
endfunction

