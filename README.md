# Vroutine
 Vroutine is a coroutine library that allow code execution in "parallel" with the use of simple function
# Platforms 
 the library is built on top of minicoro which support most of the popular platforms like windows linux macos and android 
# Why
 V does have a very good concurrency model but it only supports native threads which means having a shared variable or a variable that can be accessed from every thread can be challanging 
 
 but with coroutines you dont actually use threads you are still in the main thread but you make code excute and freeze in certain states 
 
 this picture of kotlin coroutines explains it better 
 
 ![image](https://user-images.githubusercontent.com/58748332/192161898-c5264598-749c-4291-8b91-05018ef4bfca.png)

# Examples 
 you can find some examples with the library to explain how it works 
