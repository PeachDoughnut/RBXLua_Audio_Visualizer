
local timediff = 0.25 --uploaded audio is slightly offset from video's audio

--at 30 fps, 1 frame = 0.0333

local subs = {
	{
		28.005-timediff, 33.084-timediff,
		"dare mo oboetenai kimi o\nI'll keep watch over you,",
		"誰も覚えてない君を"
	},
	{
		33.084-timediff, 36.48-timediff,
		"mimamori tsuzukeru\nwho no one remembers,",
		"見守り続ける"
	},
	{
		36.48-timediff, 41.12-timediff,
		"boku no inochi ga owaru made\nuntil my life is over",
		"僕の命が終わるまで"
	},
	{
		41.495-timediff, 46.24-timediff,
		"kimi no shiranai mirai kara\nFrom the future you have yet to see,",
		"君の知らない未来から"
	},
	{
		46.24-timediff, 50.2-timediff,
		"utai tsuzuketeru\nI keep singing",
		"歌い続けてる"
	},
	{
		50.2-timediff, 54.96-timediff,
		"tatoe juunen sugite mo\neven after ten years will have passed",
		"たとえ１０年過ぎても"
	},
	{
		55.72-timediff, 60.72-timediff,
		"amai yume　yadoru omoi ni\nWith sweet dreams and lingering thoughts",
		"甘い夢　宿る想いに"
	},
	{
		61.34-timediff, 67.32-timediff,
		"tsutau nada　haruka tooku tooku e\ntears flow to a place far far away",
		"伝う涙　遥か遠く遠くへ"
	},
	{
		69.36-timediff, 74.06-timediff,
		"yasashisa ni michiafureteta\noverflowing with gentleness",
		"優しさに満ち溢れてた"
	},
	{
		74.4-timediff, 81.26-timediff,
		"kimi no koe wa mou doko ni mo nai kedo\nYour voice is already lost but",
		"君の声はもう何処にもないけど"
	},
	{
		82.14-timediff, 88.25-timediff,
		"itoshimi ga yami o terashi\nyour love illuminates the darkness",
		"愛しみが闇を照らし"
	},
	{
		88.9-timediff, 95.5-timediff,
		"soyokaze ga hohoemidasu\nand the breeze smiles upon me",
		"そよ風が微笑みだす"
	},
	{
		96.355-timediff, 101.32-timediff,
		"fukisugiru kaze no tayori ni\nWith news carried by the squally wind",
		"吹きすぎる風の便りに"
	},
	{
		101.32-timediff, 104.829-timediff,
		"kanashimi ga ureu\nsorrow befalls me",
		"悲しみが憂う"
	},
	{
		104.829-timediff, 109.62-timediff,
		"setsunage na kaori ni michite\nfilled with a heartwrenching scent",
		"切なげな香りに満ちて"
	},
	{
		110.36-timediff, 115.44-timediff,
		"ima demo kokoro no naka de wa\nEven now inside my heart",
		"今でも心の中では"
	},
	{
		115.44-timediff, 118.761-timediff,
		"kimi no kage ga mada\nyour shadow is still",
		"君の影がまだ"
	},
	{
		118.761-timediff, 126.7-timediff,
		"boku no shi o matteru\nwaiting for my death",
		"僕の死を待ってる"
	},
	{
		144.776-timediff, 150.187-timediff,
		"yume no naka　shizuku ga ochita\nInside a dream, a drop fell",
		"夢の中　雫が落ちた"
	},
	{
		150.187-timediff, 156.72-timediff,
		"yakitsuite hanarenai sono sugata\nThis inseperable burned figure",
		"焼きついて離れないその姿"
	},
	{
		157.80-timediff, 163.67-timediff,
		"shiawase ni kodoku ga ochita\nhappily fell into solitude",
		"幸せに孤独が落ちた"
	},
	{
		163.67-timediff, 170.74-timediff,
		"toiki　kanade　yamanai oto no naka de\nSighs play among a neverending note",
		"吐息　奏で　止まない音の中で"
	},
	{
		171.3-timediff, 177.47-timediff,
		"kimi ga mada　hana no youni\nYou are still like a flower",
		"君がまだ　花のように"
	},
	{
		178.08-timediff, 184.24-timediff,
		"waratteru　boku o mizu ni\nLaughing, without looking at me",
		"笑ってる　僕を見ずに"
	},
	{
		197.55-timediff, 202.68-timediff,
		"dare mo oboetenai kimi o\nI'll keep watch over you,",
		"誰も覚えてない君を"
	},
	{
		202.68-timediff, 206.06-timediff,
		"mimamori tsuzukeru\nwho no one remembers,",
		"見守り続ける"
	},
	{
		206.06-timediff, 210.859-timediff,
		"boku no inochi ga owaru made\nuntil my life is over",
		"僕の命が終わるまで"
	},
	{
		211.512-timediff, 216.567-timediff,
		"ima demo kokoro no naka de wa\nEven now inside my heart",
		"今でも心の中では"
	},
	{
		216.567-timediff, 219.903-timediff,
		"kimi no kage ga mada\nyour shadow is still",
		"君の影がまだ"
	},
	{
		219.903-timediff, 228.177-timediff,
		"boku no shi o matteru\nwaiting for my death",
		"僕の死を待ってる"
	},
	{
		238.77-timediff, 241.493-timediff,
		"Thank you.",
		"サンキュ。",
		"Thank you."
	}
}

return subs