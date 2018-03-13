#hàm tải ảnh từ google vào thư mục con với 2 tham số truyền vào $count(1) và $date(2)
function dow_img(){
cd /home/scode/sonha/$2/
sudo chmod 777 .
imagelink=$(wget --user-agent 'Mozilla/5.0' -qO - "https://www.google.com/search?client=ubuntu&hs=V3E&channel=fs&tbm=isch&sa=1&ei=VmujWoGzJ4Of0gSZmZSQCA&q=ha&oq=ha&gs_l=psy-ab.3..0i67k1j0l2j0i67k1j0l4j0i67k1j0.13179.13324.0.13488.2.2.0.0.0.0.127.249.0j2.2.0....0...1c.1.64.psy-ab..0.2.246....0.2QSaP1Bhu7s" | sed 's/</\n</g' | grep '<img' | head -n"$1" | tail -n1 | sed 's/.*src="\([^"]*\)".*/\1/g')
wget $imagelink 
return 0
}

#hàm tạo thư mục cha
function create_folder(){
	#tạo thư mục
	sudo mkdir -p /home/scode/sonha/
	#lấy ngày của hiện tại
	bien=$(date +%a)
	#khai báo mảng các ngày trong tuần 
	array_var[0]="T2"
	array_var[1]="T3"
	array_var[2]="T4"
	array_var[3]="T5"
	array_var[4]="T6"
	array_var[5]="T7"
	array_var[6]="CN"	
	#đếm số lần vòng lặp for chạy đến khi so sánh được ngày trùng
	dem=0;
	for((i=0;i<7;i++))
	do	
		((dem++))
	
		if [[ $bien = ${array_var[$i]} ]]
		then 
			#tạo 7 thư mục con
			count=2
			for((j=dem-1;j>=0;j--))
			do
				lastdate=$(date -d"now -$j day" +"%Y-%m-%d")
				sudo mkdir -p /home/scode/sonha/$lastdate/
				dow_img $count $lastdate
 				((count++))
			done
			#day: biến để tính ngày tương lai tiếp theo
			day=1
			for((j=$dem;j<7;j++))
			do
				futuredate=$(date -d"now + $day day" +"%Y-%m-%d")
				sudo mkdir -p /home/scode/sonha/$futuredate/
				dow_img $count $futuredate
				((count++))
 				((day++))
			done
		fi
	
	done
	return 0
}

#main()
#kiểm tra thư mục có tồn tại hay không
link=$("/home/scode/sonha/")
if [ -d $link];
then
	#nếu tồn tại thư mục thì xóa đi,tạo lại thư mục
	cd /home/scode/sonha/
	sudo chmod 777 .
	sudo rm -r /home/scode/sonha
	create_folder
else
	#nếu thư mục không tồn tại thì tạo thư mục mới
	create_folder
fi 

echo "day la dfjdfa"
echo "ha sua lan 2"
echo "ha sua lan 3"
