
L_TestTable={

    a = 10,
    [-216]={["id"]=-216,["大牌"]="laowang",["小牌"]="xiaohongjoker",["迷你牌"]="xxhongjoker"},
    [-115]={["id"]=-115,["大牌"]="xiaowang",["小牌"]="xiaohuijoker",["迷你牌"]="xxhuijoker"},
    [114]={["id"]=114,["大牌"]="heitaoA",["小牌"]="xiaoheitaoA",["迷你牌"]="xxheitaoA"},
    [113]={["id"]=113,["大牌"]="heitaoK",["小牌"]="xiaoheitaoK",["迷你牌"]="xxheitaoK"},
    [112]={["id"]=112,["大牌"]="heitaoQ",["小牌"]="xiaoheitaoQ",["迷你牌"]="xxheitaoQ"},
    [111]={["id"]=111,["大牌"]="heitaoJ",["小牌"]="xiaoheitaoJ",["迷你牌"]="xxheitaoJ"},
    [110]={["id"]=110,["大牌"]="heitao10",["小牌"]="xiaoheitao10",["迷你牌"]="xxheitao10"},
    [109]={["id"]=109,["大牌"]="heitao9",["小牌"]="xiaoheitao9",["迷你牌"]="xxheitao9"},
    [108]={["id"]=108,["大牌"]="heitao8",["小牌"]="xiaoheitao8",["迷你牌"]="xxheitao8"},
    [107]={["id"]=107,["大牌"]="heitao7",["小牌"]="xiaoheitao7",["迷你牌"]="xxheitao7"},
    [106]={["id"]=106,["大牌"]="heitao6",["小牌"]="xiaoheitao6",["迷你牌"]="xxheitao6"},
    [105]={["id"]=105,["大牌"]="heitao5",["小牌"]="xiaoheitao5",["迷你牌"]="xxheitao5"},
    [104]={["id"]=104,["大牌"]="heitao4",["小牌"]="xiaoheitao4",["迷你牌"]="xxheitao4"},
    [103]={["id"]=103,["大牌"]="heitao3",["小牌"]="xiaoheitao3",["迷你牌"]="xxheitao3"},
    [102]={["id"]=102,["大牌"]="heitao2",["小牌"]="xiaoheitao2",["迷你牌"]="xxheitao2"},
    [214]={["id"]=214,["大牌"]="hongtaoA",["小牌"]="xiaohongtaoA",["迷你牌"]="xxhongtaoA"},
    [213]={["id"]=213,["大牌"]="hongtaoK",["小牌"]="xiaohongtaoK",["迷你牌"]="xxhongtaoK"},
}


-- L_ReadOnly.table_read_only(L_TestTable)
L_TestTable = table_read_only(L_TestTable)
print("read only")
-- print(L_TestTable[114].id)
-- print(type(L_TestTable[114].id))
-- L_TestTable[114] = {}
-- print(L_TestTable[114].id)
-- L_TestTable.a = 119
-- print(L_TestTable.a)
-- L_TestTable[114] = 10
-- print(L_TestTable[114].id)