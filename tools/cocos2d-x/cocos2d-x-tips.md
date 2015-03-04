两阶段构造器及静态create()

1. 第一阶段运行C++类构造器，默认构造器，成员变量需设定为默认值，不该在默认构造器中编写任何逻辑因为默认构造器不能返回任何逻辑正确与否的bool值
2. 第二阶段调用MyClass::init()函数
在cocos2d-x中，对两阶段进行了包装，并在静态函数create()中自动释放引用计数，推荐使用此法

如果属性为“只读”，将不会有setProperty(type)方法；

如果属性为一个bool值，将会有setProperty(bool)及 isProperty()方法。 比如：Sprite::isDirty()和Sprite::setDirty(bool bDirty)。

如果属性不是一个bool值，将会有 setProperty(type) 和 getProperty() 方法。比如： void Sprite::setTexture(Texture2D\*) 和 Texture2D* CCSprite::getTexture()。

* Director：负责切换scene
* Scene：场景，包含子layer
* Layer：每层
* Sprite：动态

采用和openGL一样的右手系坐标

左下角为(0, 0)

Anchor Point：

    定位和旋转的中心点，定位位置之前，先定位Anchor Point，默认Anchor Point为中心

* getVisibleSize
* getVisibleOrigin
* getWinSize

convertToNodeSpace：CCPoint point = node1->convertToNodeSpace(node2->getPosition());转换node2的坐标到node1下，用node1的坐标系来定位node2

convertToWorldSpace：用node1的坐标系来定位node2，screen坐标

convertToWorldSpaceAR：使用Anchor Point来定位

创建一个CCNode：

    CCSprite* parent = CCSprite::create("parent.png");//先create
    parent -> setAnchorPoint(ccp(0, 0));//设置位置
    parent -> setPosition(ccp(100, 100));
    parent -> setAnchorPoint(ccp(0, 0));
    addChild(parent);//this->addChild(xxx)，加入
