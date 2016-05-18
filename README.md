# docker_dubbo_sketch
一个简单的Dubbo部署到Docker容器的示例工程及脚本

包括三个工程：
- demo-api      : Dubbo的服务接口声明
- demo-provider : Dubbo的服务提供者，是一个App工程
- demo-web      : Dubbo的服务消费者，是一个WEB工程

## demo-api
这个就不说了，基本的Dubbo服务接口声明

## demo-provider
Dubbo提供者，实现可参考dubbo.io
本示例采用App启动服务，参考com.alibaba.dubbo.container.Main类实现。

重点是看脚本目录
- /bin/start.sh 用于在本机启动Provider，可指定端口，如 ./start.sh 30881
- /bin/stop.sh 用于在本机停止Provider，必须指定端口，如 ./stop.sh 30881
- /bin/start_in_docker.sh 用于启动Provider容器，可以指定端口，如 ./start_in_docker.sh 30881
- /bin/provider_run_in_docker.sh 这个脚本被start_in_docker.sh使用，在容器中执行，不要手工执行它

配置目录
- /conf/application-context.xml Spring的配置文件，可根据项目具体情况手工修改
- /conf/demo-provider.xml Dubbo的配置文件，可根据项目具体情况手工修改
- /conf/app.properties 应用配置文件，需要根据项目具体情况手工修改

在package时，Maven会打包输出一个tar.gz文件，包括了编译输出的jar以及配置和脚本文件。

## demo-web
Dubbo消费者，实现是一个普通的WEB工程。

同样看脚本目录
- /bin/run_web.sh 启动Tomcat容器，并挂载当前工程生成的war文件

配置目录
- /conf/catalina.sh 代替缺省的Tomcat容器中对应文件，增加JAVA_OPTS参数配置
- /conf/server.xml 代替缺省的Tomcat容器中对应文件，增加TheadPool等支持
- /conf/app.properties 应用配置文件，需要根据项目具体情况手工修改

在package时，Maven会打包输出一个tar.gz文件，包括了编译输出的war以及配置和脚本文件。
