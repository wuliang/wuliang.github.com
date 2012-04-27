---
layout: post
title: This is not the way to do a tree structure
tags : [SQL, Tree, tuition]
---
{% include JB/setup %}

[from codeproject](http://www.codeproject.com/Articles/162368/Implementing-a-Tree-Structure-with-Database)
Auther: Daniel Parnell

 This is not the way to do a tree structure! 
------------------------------------

I don't know how many times I've had to deal with tree structures implemented like this. I know I made this same mistake when I was starting out with databases. On the surface it looks like the way to do it, but there are several much better ways to do it. The problem with this approach is that traversing the tree is a very expensive operation. If the tree is only 2 or 3 levels deep this may not be a problem, but as soon as the tree starts to get deep it does not scale well (I remember getting yelled at by a DBA for doing this   ).
 
One of the easiest ways to implement a tree structure that is easy to traverse is to use a structure as follows:
 {% highlight sql %} 
create table my_tree (
  id int IDENTITY(1,1) NOT NULL,
  path VARCHAR(200) not null,
  title nvarchar(200) not null
)
{% endhighlight %} 
We make a trade off between disk space and access speed. This would allow us to easily store a tree with 50 levels or more (make the path column longer to allow deeper trees).
 
<table>
    <tr>
        <td>id</td><td>path</td><td>title</td>
    </tr>
    <tr>
        <td>1</td><td>/</td><td>this is the root</td>
    </tr>
    <tr>
        <td>2</td><td>/1</td><td>this is the first item under the root</td>
    </tr>
    <tr>
        <td>3</td><td>/1</td><td>another item under the root</td>
    </tr>
    <tr>
        <td>4</td><td>/1/2</td><td>an item under the first item under the root</td>
    </tr>
    <tr>
        <td>5</td><td>/1/2/4</td><td>a deeper item</td>
    </tr>
</table>
 
To get the whole tree you can then do the following:
 {% highlight sql %}  
select * from my_tree order by  path+'/'+cast(id as varchar)
{% endhighlight %}  
The expression in the order by could be eliminated if the path were updated to contain the full path to the node rather than the path to the parent. To do this nicely we would need to pre-allocate the node ID or use some other method for identifying the nodes that does not relate to the ID column.
 
To get a sub-tree:
 {% highlight sql %}
select * from my_tree where path like '/1/2/%' order by  path+'/'+cast(id as varchar)
{% endhighlight %} 
Similarly deleting a sub-tree becomes:
 {% highlight sql %} 
delete from my_tree where path like '/1/2/%'
{% endhighlight %} 
Moving items around in the tree becomes a little more complicated.
 {% highlight sql %}
update my_tree set path='/1/3/'+substring(path, 6, 1000) where path like '/1/2/%'
{% endhighlight %}
 
There are a couple of even more efficient ways of implementing trees, but they are a lot more complicated to implement.
See [here](http://www.codeproject.com/KB/database/nestedsets.aspx) an example 

### More about Sqlite3 (by wuliang)
In SQlite3, there should be some modification like this:
{% highlight sql %}
update my_tree set path='/1/3/'|| substr(path, 6) where path like '/1/2/%'
{% endhighlight %}


