
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
spring.datasource.username=root
spring.datasource.password=your_password
```

### 宝塔云服务器配置
1. 服务器信息：
   - 外网面板地址: https://121.36.86.147:12666/14d040ec
   - 内网面板地址: https://192.168.0.139:12666/14d040ec
   - 需在安全组放行12666端口

2. 远程数据库连接配置(修改application.properties):
```properties
spring.datasource.url=jdbc:mysql://121.36.86.147:3306/springboot-vue?useUnicode=true&characterEncoding=utf-8&allowMultiQueries=true&useSSL=false&serverTimezone=GMT%2b8
spring.datasource.username=springboot-vue
spring.datasource.password=waSGtHKABCesdTwf
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
2. 默认管理员账号: admin/admin123
3. 普通用户账号: user/user123

## 注意事项
1. 确保MySQL服务已启动
2. 首次运行前请先导入SQL文件
3. 修改配置后需要重启应用
