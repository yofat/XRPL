# 安裝 ripple
### 沒記錯是因為 XRP 將程式設計外包給 ripple
### 理論上可以無腦複製貼上不會出錯
### 網址：https://xrpl.org/docs/infrastructure/installation/install-rippled-on-ubuntu
------------------------------------------------------
## 假定：一台空機，剛安裝到虛擬機上面
#### 更新作業系統並安裝你的更新
```bash
sudo apt update -y && sudo apt upgrade -y
```
#### 安裝這4個東西
```bash
sudo apt -y install apt-transport-https ca-certificates wget gnupg
```
#### 把 package-signing GPG 鑰匙 列入信任的鑰匙
```bash
sudo install -m 0755 -d /etc/apt/keyrings && \
    wget -qO- https://repos.ripple.com/repos/api/gpg/key/public | \
    sudo gpg --dearmor -o /etc/apt/keyrings/ripple.gpg
```
#### 檢查你的 fingerpoint
```bash
gpg --show-keys /etc/apt/keyrings/ripple.gpg
```
#### 把 ripple 的 repository 加進去，並且要改成你的作業系統版本
#### 前言裡有說我是水母版的
```bash
echo "deb [signed-by=/etc/apt/keyrings/ripple.gpg] https://repos.ripple.com/repos/rippled-deb jammy stable" | \
    sudo tee -a /etc/apt/sources.list.d/ripple.list
```
#### 安裝 ripple
```bash
sudo apt -y update && sudo apt -y install rippled
```
#### 查看 ripple 伺服器狀態
```bash
systemctl status rippled.service
```
#### 如果他沒自動運作可以用手動的
```bash
sudo systemctl start rippled.service
```
#### (可選) 允許 ripple 綁到特定的 ports (EX. 80、443)
```bash
sudo setcap 'cap_net_bind_service=+ep' /opt/ripple/bin/rippled
```
#### (可選) 設定 core dumps
###### 核心檔案（core file），也稱磁芯傾印（core dump），是作業系統在行程收到某些訊號而終止執行時，將此時行程位址空間的內容以及有關行程狀態的其他資訊寫入一個磁碟檔案。
```bash
ulimit -c unlimited
```
#### 跑這行指令修改裡面的檔案，但其實就是把註解刪掉，預設好像會是 nano
```bash
sudo systemctl edit rippled
```
#### 要設定的字
```json
[Service]
LimitCORE=infinity
```
#### 存檔後他會建立一個檔案
- /etc/systemd/system/rippled.service.d/override.conf
#### 可以用這行指令查看 core dump
```bash
gdb /opt/ripple/bin/rippled /var/lib/apport/coredump/core
```
#### ripple 伺服器 info 查看
```bash
rippled server_info
```
