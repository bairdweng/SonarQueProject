#!/bin/bash
echo -e "\033[32m--------正在编译中-------------\033"

myworkspace=../SonarQueProject.xcworkspace
myscheme=SonarQueProject

# 清空缓存
xcodebuild -scheme $myscheme -workspace $myworkspace clean

# 开始编译
xcodebuild -scheme $myscheme \
-workspace $myworkspace \
-configuration Debug \
-destination 'generic/platform=iOS' \
COMPILER_INDEX_STORE_ENABLE=NO \
| xcpretty \
-r json-compilation-database \
-o compile_commands.json


# oclint
echo -e "\033[32m--------开始分析代码-------------\033"

# 判断和项目根目录是否存sonar-reports,并创建
if [ ! -d sonar-reports ]; then
mkdir sonar-reports
fi

# 项目根目录创建sonar-reports是因为sonar-scanner命令默认获取根目录下sonar-reports的xml配置，暂未找到配置方法。
if [ ! -d ../../sonar-reports ]; then
mkdir ../../sonar-reports
fi

# 生成oclint.xml -i MZAudio/Home/controller 暂时指定一个目录，全工程时间消耗将近1小时。
oclint-json-compilation-database \
    -e Pods \
    -- -report-type pmd \
    -o sonar-reports/oclint.xml \
    -rc LONG_LINE=200 \
    -disable-rule ShortVariableName \
    -disable-rule ObjCAssignIvarOutsideAccessors \
    -disable-rule AssignIvarOutsideAccessors \
    -max-priority-1=100000 \
    -max-priority-2=100000 \
    -max-priority-3=100000

# 拷贝一份xml并覆盖到根目录下的sonar-reports
cp -rf ./sonar-reports/oclint.xml ../sonar-reports/oclint.xml

# 执行sonar-scanner
echo -e "\033[32m--------分析成功开始上传到sonar-scanner平台-------------\033"
sonar-scanner