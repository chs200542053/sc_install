#!/bin/bash

# 颜色代码
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m" 
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

# 1、安装环境
install_env(){
  blue "更新 apt 软件包索引并升级已安装的所有软件包到最新版本"
  apt update -y && apt full-upgrade -y
  blue "安装nvm和nodejs"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  source ~/.bashrc
  nvm install node -y
  nvm install nodejs -y
  blue "安装git"
  sudo apt install git -y
  blue "安装 screen"
  apt install screen
}

# 2、安装 SillyTavern
install_silly(){
  # 克隆SillyTavern仓库
  git clone https://github.com/SillyTavern/SillyTavern
  cd SillyTavern
  bash start.sh
  blue "SillyTavern安装完毕，请去SillyTavern目录下config.yaml添加账号密码"
}

# 3、安装 clewd
install_clewd(){
  # 克隆SillyTavern仓库
  git clone https://github.com/teralomaniac/clewd.git
  cd clewd
  bash start.sh
  blue "clewd安装完毕，请去clewd目录下config.conf填入cookie"
}

# 4、运行 SillyTavern
run_silly(){
  screen -S SillyTavern
  cd ~/SillyTavern
  bash start.sh
  blue "下次可以使用 screen -r SillyTavern 回到此窗口"
}

# 5、运行 clewd
run_clewd(){
  screen -S clewd
  cd ~/clewd
  bash start.sh
  blue "下次可以使用 screen -r clewd 回到此窗口"
}

# 6、更新 clewd
run_clewd_update(){
  cd clewd
  bash update.sh
}

# 7、更新 SillyTavern

# 8、安装/卸载虚拟内存
run_swap(){
  blue "酒馆安装1024mb足够"
  wget -O "/root/swap.sh" "https://raw.githubusercontent.com/BlueSkyXN/ChangeSource/master/swap.sh" --no-check-certificate -T 30 -t 5 -d
  chmod +x "/root/swap.sh"
  chmod 777 "/root/swap.sh"
  blue "下载完成"
  blue "你也可以输入 bash /root/swap.sh 来手动运行"
  bash "/root/swap.sh"
}

# 9、启动BBR FQ算法
run_bbrfq(){
remove_bbr_lotserver
  echo "net.core.default_qdisc=fq" >> /etc/sysctl.d/99-sysctl.conf
  echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.d/99-sysctl.conf
  sysctl --system
  echo -e "BBR+FQ修改成功，重启生效！"
}

#主菜单
function start_menu(){
    clear
    red " 【宝宝专用】SillyTavern + Clewd 一键安装脚本" 
	green " FROM: https://github.com/BlueSkyXN/SKY-BOX "
    green " USE:  wget -O sc_install.sh https://raw.githubusercontent.com/chs200542053/sc_install/main/sc_install.sh && chmod +x sc_install.sh && clear && ./sc_install.sh "
    yellow " ========================【交流方式】======================"
    blue " Claude牛排冒菜馆(萌新互助群1)：910524479" 
    blue " Claude水秋海洋馆(萌新互助群2)：304690608" 
    blue " Claude2.0先行破限组(大群)：704819371" 
    blue " 类脑Discord(角色卡发布): https://discord.gg/HWNkueX34q" 
    yellow " ========================【安装】========================"
    green " 1、安装环境" 
    green " 2、安装 SillyTavern"
    green " 3. 安装 clewd"
    yellow " ========================【运行】========================"
    green " 4. 运行 SillyTavern" 
    green " 5. 运行 clewd"
    yellow " ========================【更新】========================"
    green " 6. 更新 clewd"
	green " 7. 更新 SillyTavern(尚未完工勿选)"
	yellow " ========================【优化】========================"
	green " 8. 安装/卸载虚拟内存（酒馆安装1024mb足够）"
	green " 9. 启动BBR FQ算法（网络加速）"
    yellow " ========================================================"
    blue " 0. 退出脚本"
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           install_env
		;;
        2 )
           install_silly
		;;
        3 )
           install_clewd
		;;
        4 )
           run_silly
		;;
        5 )
           run_clewd
		;;
		6 )
           run_clewd_update
		;;
		6 )
           run_clewd_update
		;;
		8 )
           run_swap
		;;
		9 )
           run_bbrfq
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "请输入正确数字 !"
            start_menu
        ;;
    esac
}
start_menu "first"
