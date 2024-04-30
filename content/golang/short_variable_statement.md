---
title: "short variable statement"
date: 2024-01-18T20:30:00+08:00
---
都已声明：

https://play.golang.org/p/GaPtiEn7yTL

其中一个已声明：

https://play.golang.org/p/xQGl8kXyUsl

https://play.golang.org/p/UujXGbQ9voY

两个都未声明：

https://play.golang.org/p/TczAQ81LbME

在内层代码块中使用短变量声明，和外部变量同名的会覆盖外部变量。

短变量声明本质上就是变量生明，没有什么特殊之处。即使左值有多个，也都是新变量声明。

如果是在同一代码块里，短变量声明又是可以智能判断是否新声明变量，https://play.golang.org/p/S9ksXvyRTYS