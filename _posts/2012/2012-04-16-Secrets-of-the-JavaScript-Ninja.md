---
layout: post
tags : [javascript, Prototype, tuition]
---
{% include JB/setup %}

[http://ejohn.org/apps/learn](http://ejohn.org/apps/learn)

 Secrets of the JavaScript Ninja
------------------------------------

This tutorial contains code and discussion from the upcoming book "Secrets of the JavaScript Ninja" by John Resig.
It is a perfect tuition including 90 pages, and reader can edit code ,run code and see the result.

### **Check my studying **

Goal: To be able to understand this function (according to page 2)

{% highlight javascript %}
// The .bind method from Prototype.js 
Function.prototype.bind = function(){ 
  var fn = this, args = Array.prototype.slice.call(arguments), object = args.shift(); 
  return function(){ 
    return fn.apply(object, 
      args.concat(Array.prototype.slice.call(arguments))); 
  }; 
};
{% endhighlight %}

My Answer:
{% highlight javascript %}
// The .bind method from Prototype.js 
Function.prototype.bind = function(){ 
/*
[1] "this" used to record the context when call function is bound.
Usually "this" is the object contain the function to be bound.

[2] "slice" is used to generate  real array from a pesudo-array(here is arguments), 
so array functions can be used. Use "call" to give slice a context(data)  to operate on. 
By default, we "new Array()" to generate a object and "object.slice" will make "object" as context.

[3] "shift" fetch the 1st parameter, and remain others in "args"

[4] variants of "fn, object, args" in the anonymous function will be  
closured(record their values and used when the function is invoked) 

[5] "args.concat" means the real parameters feed the function (object) 
will include the parameters given in "binding" phase, and parameters 
given in "callback" phase. 
*/

  var fn = this, args = Array.prototype.slice.call(arguments), object = args.shift(); 
  return function(){ 
    return fn.apply(object, 
      args.concat(Array.prototype.slice.call(arguments))); 
  }; 
};
{% endhighlight %}
