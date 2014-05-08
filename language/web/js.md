js类
构造函数，this和prototype属性
function Cat(name, color)
{
  this.name = name;
  this.color = color;
}

Cat.prototype.type = "猫科动物"
Cat.prototype.eat = function(){alert("吃老鼠")};

共有的属性使用prototype
