---
title: "Channels"
date: 2020-09-21T14:49:06+08:00
draft: true
---

# Channels
## Send & Receive
```
ch <- v  // send v to channel ch.
v := <- ch  // receive from ch, assign value to v.
```
## Send-only & Receive-only channels
```
ch := make(chan int, 1)
var ro <-chan int = ch
var so chan<- int = ch
```
只发送channel的接收操作或只接收channel的发送操作都会在报编译错误：
./prog.go:11:2: invalid operation: <-w (receive from send-only type chan<- int)

## Close channel
1. Channel 不需要像 File 一样使用后需要关闭，所以一般情况下不需要 close，除非需要通知 range 停止对 channel 的读取。
2. 只能在 send 端来关闭。对只接收 channel 进行 close 会报编译错误：
   ./prog.go:13:7: invalid operation: close(r) (cannot close receive-only channel)
3. Close 后的 channel，发送操作会 panic：
   panic: send on closed channel
   接收操作会获取到 channel 元素类型的零值。

## Select
等待多个通信操作，直到其中一个可以执行。如果有多个操作可以执行，**随机**执行一个。[playground示例](https://play.golang.org/p/lErRHUQf5aq)
