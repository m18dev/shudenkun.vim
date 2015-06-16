function! shudenkun#init_last_train()
  let a:json = webapi#http#get(g:last_train_host . "/api/last_train.json?user_id=" . g:last_train_user_id . "&depature=" .  webapi#http#encodeURIComponent(g:last_train_work_place))
  let a:data = webapi#json#decode(a:json["content"])
  let g:last_train_remain_sec = a:data["remain_min"] * 60
  let g:stay_all_with_vim = 1
  let g:origin_timestamp = localtime()
endfunction

function! shudenkun#check_last_train()
  let a:run_sec = localtime() - g:origin_timestamp
  let a:remain_sec = g:last_train_remain_sec - a:run_sec
  "let a:remain_sec = 599
  if a:remain_sec < 600 && g:stay_all_with_vim == 1
    let a:choice = confirm(" 終電まで後" . a:remain_sec . "秒です。vimと一夜をともにしますか？", "&Y yes\n&N no")
    if a:choice == 1
      let g:stay_all_with_vim = 0
      echo "ごゆっくり。。。"
    endif
    if a:choice == 2
      echo "早く帰ろう"
    endif
  else
    echo(" 終電まで後" . a:remain_sec . "秒です。")
  endif
endfunction
