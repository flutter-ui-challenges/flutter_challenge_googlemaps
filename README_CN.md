# 

# flutter_challenge_googlemaps

使用go-flutter实现[uplabs](https://www.uplabs.com/posts/google-maps-redesign-919dd0d6-0883-4378-b5b2-f77e36adb6b5)上Google Maps的UI挑战

> 设计师 : [Joydeep Sengupta](https://www.uplabs.com/joydeeproni)
>
> Uplabs : <https://www.uplabs.com/posts/google-maps-redesign-919dd0d6-0883-4378-b5b2-f77e36adb6b5>
>
> 开发者 : [ditclear](https://github.com/ditclear)

#### 项目介绍 

| 分支                                                         | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [master](<https://github.com/flutter-ui-challenges/flutter_challenge_googlemaps>) | 使用 `setState` 来通知UI更新                                 |
| [provide](https://github.com/flutter-ui-challenges/flutter_challenge_googlemaps/tree/provide) | 使用  [flutter-provide来通知UI更新                           |
| [desktop](https://github.com/flutter-ui-challenges/flutter_challenge_googlemaps/tree/desktop) | 使用 [go-flutter](https://github.com/go-flutter-desktop/go-flutter) 来完成桌面端 |

### 运行

1. 安装Go ，由于Go flutter使用Go编写，所以需要安装Go工具包。大家可以在[官网下载安装](https://link.juejin.im/?target=https%3A%2F%2Fgolang.org%2Fdoc%2Finstall)

2. 安装hover，hover是 Go Flutter的一个命令行工具，简化了项目初始化以及运行等步骤。

   使用下面命令安装

   ```
   go get -u github.com/go-flutter-desktop/hover
   ```

配置hover路径

> export PATH=$PATH:/usr/local/go/bin
>
> export PATH=$PATH:/Users/{你的用户名}/go/bin

3. 进入项目 运行程序

> hover run

### 效果图

![](ui/all.png)



![](ui/attachment.gif)



![](ui/preview.gif)



### License

```
Copyright 2019 ditclear

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```











