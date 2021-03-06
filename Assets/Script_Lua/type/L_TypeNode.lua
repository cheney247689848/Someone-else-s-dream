L_TypeColorNode = {
    
    NONE = -1,
    RED = 0, --红
	YELLOW = 1, --黄
	BLUE = 2, --蓝
    GREEN = 3, --绿
    WHITE = 4, --白
    PURPLE = 5, --紫
    BLACK = 6, --黑
}

L_TypeStatusNode = {

    NONE = -1,              --无效状态
    IDLE = 0,               --空闲状态
    CREAT = 1,              --创建状态
    DROP = 2,               --坠落状态
    TRANF = 3,              --被转移状态
    AN_ELIMINATE = 4,       --当前消除位置检测
    ELIMINATE = 5,          --消除状态
    PRE_DROP = 6,           --坠落前状态
    TES_DROP = 7,           --坠落检测状态
    REFURBISH = 8,          --刷新状态

    FIXED_OBJECT = 10,      --固定 物体状态


    FREEZE = 21,            --冰冻状态
    SAND = 22,              --流沙状态
    ANIMATION = 30,         --动画
    OPERATION = 40,         --操作
    BOOM_PRE_ANIM = 50,     --前置动画
    MONSTER = 60,           --怪物占用
}