#!/bin/bash

ln_file()
{
  src=`pwd`/$1
  file_name=`basename $1`
  dst_dir=$2
  dst_file=${dst_dir}/${file_name}
  if [ -L ${dst_file} ];then
    rm -vf ${dst_file}
  fi
  ln -svf ${src} ${dst_file}
}

ln_file .vimrc ~/
ln_file .vim ~/
ln_file .gitconfig ~/
ln_file .tmux.conf ~/
