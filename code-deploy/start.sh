#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

echo "  > Jar 복사를 시작합니다."
echo "  > Jar를 모아놓는 디렉토리를 생성합니다. 있으면 생성하지 않습니다."
jar_dir_path=/home/ec2-user/jar/
mkdir -p ${jar_dir_path}

echo "  > Jar 이름을 찾습니다."
jar_name=$(basename /home/ec2-user/deploy/*.jar)
echo "  > Jar 이름: $jar_name"

echo "  > Jar 파일을 ${jar_dir_path}로 복사합니다."
cp /home/ec2-user/deploy/*.jar ${jar_dir_path}
jar_deploy_path=${jar_dir_path}${jar_name}

echo "  > ${jar_deploy_path}를 실행합니다."
idle_profile=$(find_idle_profile)
nohup java -jar -Dspring.profiles.active=${idle_profile} ${jar_deploy_path} >> /home/ec2-user/jar/nohup.out 2>&1 &