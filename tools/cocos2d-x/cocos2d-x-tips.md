Director：负责切换scene
Scene：场景，包含子layer
Layer：每层
Sprite：动态

采用和openGL一样的右手系坐标
左下角为(0, 0)
Anchor Point：
    定位和旋转的中心点，定位位置之前，先定位Anchor Point，默认Anchor Point为中心

getVisibleSize
getVisibleOrigin
getWinSize

convertToNodeSpace：CCPoint point = node1->convertToNodeSpace(node2->getPosition());转换node2的坐标到node1下，用node1的坐标系来定位node2
convertToWorldSpace：用node1的坐标系来定位node2，screen坐标
convertToWorldSpaceAR：使用Anchor Point来定位

创建一个CCNode：
    CCSprite* parent = CCSprite::create("parent.png");
    parent -> setAnchorPoint(ccp(0, 0));
    parent -> setPosition(ccp(100, 100));
    parent -> setAnchorPoint(ccp(0, 0));
    addChild(parent);
