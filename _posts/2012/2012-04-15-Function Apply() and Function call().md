---
layout: post
tags : [javascript, API, tuition]
---
{% include JB/setup %}

[http://www.mennovanslooten.nl/blog/post/65](http://www.mennovanslooten.nl/blog/post/65)

Function.apply() and Function.call()
------------------------------------

I've been meaning to write this post for a while, now, mostly as a
reminder to myself. The subject is the two methods available for all
JavaScript functions: `apply()` and `call()`. Confusingly, they both do
the same thing in very, very similar ways: executing the function in the
scope of a specified object. I've always had trouble remembering their
major difference, however, so I decided to finally write this post and
hope it sticks.

### **What they both do**

I can make this a very technical post about the ins and outs of these
methods or I can just summarize by writing the following: **apply() and
call() allow you to specify what****`this`****will refer to inside that
function**, even when that function is a method on another object. An
example:

~~~~
{style="background: #f3f3e6; border: none; padding: 0cm; line-height: 0.47cm; widows: 2; orphans: 2"}
var someObject = {
    myProperty : 'Foo',
    myMethod : function() {
        alert(this.myProperty);
    }
};
someObject.myMethod(); // alerts 'Foo'

var someOtherObject  = {
    myProperty : 'Bar'
};
someObject.myMethod.call(someOtherObject); // alerts 'Bar'
someObject.myMethod.apply(someOtherObject); // alerts 'Bar'
~~~~

As you can see, even thought it is `someObject`'s method that is
executed, call() and apply() allows me to specify that the keyword
`this` refers to `someOtherObject`.

### **The difference**

The difference between these methods is in the way you can pass
arguments to the original function. Let's extend the example to include
arguments:

~~~~
{style="background: #f3f3e6; border: none; padding: 0cm; line-height: 0.47cm; widows: 2; orphans: 2"}
var someObject = {
    myProperty : 'Foo',
    myMethod : function(prefix, postfix) {
        alert(prefix + this.myProperty + postfix);
    }
};
someObject.myMethod('<', '>'); // alerts '<Foo>'

var someOtherObject  = {
    myProperty : 'Bar'
};
someObject.myMethod.call(someOtherObject, '<', '>'); // alerts '<Bar>'
someObject.myMethod.apply(someOtherObject, ['<', '>']); // alerts '<Bar>'
~~~~

Obviously, the difference is this: If you want to pass arguments to the
function **apply() needs an array and call() needs a list of
arguments**. That's it! Ridiculously hard to remember, I know.

\
\
\

\
\

