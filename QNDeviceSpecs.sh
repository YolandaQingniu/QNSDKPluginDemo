# podspecs 上传

#当前需要更新的版本
function update_podspecs() {
local podspecs
podspecs=$(echo "$@")
result=1
for podspec in ${podspecs[@]};do
echo ""
echo -e "\033[01;34m**正在上传 ${podspec}.podspec **\033[0m"
echo ""
pod trunk push ${podspec}.podspec --use-libraries --allow-warnings --skip-import-validation

if [ $? -ne 0 ]; then
echo ""
echo -e "\033[01;34m**${podspec}.podspec上传失败**\033[0m"
echo ""
result=0
break
else
echo -e "\033[01;34m**${podspec}.podspec上传成功**\033[0m"
fi
done
#判断是否都上传成功
if [ $result -ne 0 ]; then
echo ""
echo -e "\033[01;34m**SUCCESS**\033[0m"
echo ""
else
echo ""
echo -e "\033[01;34m**FAIL**\033[0m"
echo ""
fi
}

update_podspecs QNPlugin QNHeightWeightScalePlugin

fi
