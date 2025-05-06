
# Book Management System

## 项目依赖

### 后端依赖(SpringBoot)
- Spring Boot Starter Web
- MyBatis Spring Boot Starter
- MySQL Connector
- Lombok
- MyBatis Plus
- Hutool工具包
- Jackson JSON处理库
- Java JWT

完整依赖列表请查看`SpringBoot/pom.xml`

## 数据库配置

### 本地开发环境配置
1. 安装MySQL:
```bash
brew install mysql
brew services start mysql
```

2. 创建数据库并导入数据:
```bash
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`springboot-vue\`"
mysql -u root springboot-vue < springboot-vue.sql
```

3. 修改数据库连接配置(在`SpringBoot/src/main/resources/application.properties`中):
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/springboot-vue?useUnicode=true&characterEncoding=utf-8&allowMultiQueries=true&useSSL=false&serverTimezone=GMT%2b8
spring.datasource.username=springboot-vue
spring.datasource.password=your_password
```

### 宝塔云服务器配置
1. 服务器信息：
   - 外网面板地址: xxx
   - 内网面板地址: xxx
   - 需在安全组放行12666端口

2. 远程数据库连接配置(修改application.properties):
```properties
spring.datasource.url=jdbc:mysql://{远程数据库ip}:3306/springboot-vue?useUnicode=true&characterEncoding=utf-8&allowMultiQueries=true&useSSL=false&serverTimezone=GMT%2b8
spring.datasource.username=springboot-vue
spring.datasource.password=xxxxxx
```

## 项目启动

### 后端启动
```bash
cd SpringBoot
mvn spring-boot:run
```

### 前端启动
```bash
cd client
npm install
npm run serve
```

## 基础操作
1. 访问地址: http://localhost:8080
2. 默认管理员账号: admin/123456
3. 普通用户账号: admin1123/11231123

## 注意事项
1. 确保MySQL服务已启动
2. 首次运行前请先导入SQL文件
3. 修改配置后需要重启应用

## 目录
1. controller 处理http请求
2. entity 存放数据库实体类，对应数据库表 比如book.java对应数据库Book表
3. mapper mybatis数据访问接口  bookMapper.java 包含数据库操作方法
4. service 业务逻辑处理 impl 服务实现类
5. utils 工具类 比如TokenUtils.jave处理JWT工具类
6. 
7. resources资源配置文件
8. application.properties 配置文件 配置数据库链接，服务器端口等
9. static 静态资源 比如图片，css等
10. target 编译输出目录
11. pom.xml maven项目依赖配置文件
12. 重要重要，要下载对jdk版本否则会跑不起来，java运行选中:DemoApplication.java运行即可

