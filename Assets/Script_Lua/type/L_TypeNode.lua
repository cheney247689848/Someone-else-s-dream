L_TypeColorNode = {
    
    RED = 0; --红
	YELLOW = 1; --黄
	BLUE = 2; --蓝
    GREEN = 3; --绿
    WHITE = 4; --白
    PURPLE = 5; --紫
    BLACK = 6; --黑
}

L_TypeStatusNode = {

    NONE = -1; --无效状态
    IDLE = 0; --空闲状态
    HINT = 1; --提醒状态
    REFURBISH = 2; --刷新状态
    PRE_ELIMINATE = 3; --当前消除状态
    AN_ELIMINATE = 4; --当前消除位置检测
    ELIMINATE = 5; --消除状态
    PRE_DROP = 6; --坠落前状态
    TES_DROP = 7; --坠落检测状态
    DROP = 8; --坠落状态
    FREEZE = 21; --冰冻状态
    SAND = 22; --流沙状态
    ANIMATION = 30; --动画
    OPERATION = 40; --操作
    BOOM_PRE_ANIM = 50; --前置动画
    MONSTER = 60; --怪物占用
}