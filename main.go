package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("hello")

	k := "hello"
	fmt.Printf("%s\n", k)

	fmt.Println(time.Now().Format(time.DateTime))
    fmt.Println(time.Now().Format(time.RFC3339))

    fmt.Println(time.Now().Format(time.RFC3339Nano))
}
