extends Node
# more collectables
# last spawn index = 118

var score : int =0
var player : Player

var pause_menu
var paused = false
var necklaces_bought =[true,true,true,true,true,true,true,true] # [false,false,false,false,false,false,false,false]
var equiped_staff : int = 0
#var meele_weapeon  : int = 0
var armor : int = 0
var health :int = 50
var shield : int = 200
var weapreon_type = 1




var deadlist = {'les':[1,1,1,1,1],
'les_2':[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
'Drotaverin':[1,1,1],
'les_3':[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
'les_4':[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
'strom':[1,1,1,1,1,1,1,1,1,1 ,1,1,1,1,1,1,1],
 'lad':[1,1], 
'ice_phase_2':[1,1,1,1],
 'lad_2':[1],
"tutorial":[1,1,1],
'les_5':[],
'les_6':[],
'les_7':[],
'les_8':[],
'les_9':[],
'les_10':[],
'les_11':[],
'les_12':[],
'les_13':[],
'les_14':[],
'les_15':[],
'les_16':[],
'les_17':[],
'les_18':[],
'les_19':[],
'les_20':[],
'F1':[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
'S':[1,1,1,1,1,1,1],
'lianova_veza':[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,],
'lianova_veza_II':[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,],
'kvetiny':[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]}
var deepfrost : int =1500
var livingwood : int =1500
var ash : int =1500
var windsteel : int=1500
var gold = 10000
var magic_fire_upgrade = 0
var magic_ice_upgrade = 0
var magic_earth_upgrade = 0
var magic_wind_upgrade = 0
var magic_unlocked = true
var player_spawn = 000 # 000
var log_info 
var wisdom = {'les':[0]}

#var equiped_staff = [0,0,0,0]
var current_level_path = "res://scenes/levely/tutorial.tscn"
var meele_element = 0
var meele_bought = [0,0,1,0,1,1]
var magic_bought = [0,0,0,0,1,1,1]
var food_bought = [1,1,1,1,0,0,0,0,0]#[0,0,0,0]

var food_bought_def = [0,0,0,0,0,0,0,0,0]#[0,0,0,0]

var equiped_meele = 0
var equiped_necklace = 0
var wisdom_points = 10000
var meele_variables = [8,5,2.5,1.1] #A,F,h,sigma
var wisdom_upgrade = 0
var wisdom_upgrade_level = 0
var magic_variables = [5,1,500]
var base_health = 50
var base_shield = 200
var spent_upgrades = 0
var ui_manager# = get_tree().current_scene.get_child(0)
var options #= ui_manager.get_child(12).get_child(0)
var options_positions #= [options.get_child(0).position,options.get_child(1).position,options.get_child(2).position,options.get_child(3).position,options.get_child(4).position,options.get_child(5).position]
var opened_options #= [options.get_child(0).visible,options.get_child(1).visible,options.get_child(2).visible,options.get_child(3).visible,options.get_child(4).visible,options.get_child(5).visible]
var player_position_save 

var papers = false
var package = false


var treasures = {'les':[0,0,0,0,0],
'les_2':[0,0,0,0,0],
'Drotaverin':[0,0,0,0,0],
'les_3':[0,0,0,0,0],
'les_4':[0,0,0,0,0],
'strom':[0,0,0,0,0],
 'lad':[0,0,0,0,0], 
'ice_phase_2':[0,0,0,0,0],
 'lad_2':[0,0,0,0,0],
"tutorial":[0,0,0,0,0],
'les_5':[0,0,0,0,0],
'les_6':[0,0,0,0,0],
'les_7':[0,0,0,0,0],
'les_8':[0,0,0,0,0],
'les_9':[0,0,0,0,0],
'les_10':[0,0,0,0,0],
'les_11':[0,0,0,0,0],
'les_12':[0,0,0,0,0],
'les_13':[0,0,0,0,0],
'les_14':[0,0,0,0,0],
'les_15':[0,0,0,0,0],
'les_16':[0,0,0,0,0],
'les_17':[0,0,0,0,0],
'les_18':[0,0,0,0,0],
'les_19':[0,0,0,0,0],
'les_20':[0,0,0,0,0],
'F1':[0,0,0,0,0],
'S':[0,0,0,0,0],
'lianova_veza':[0,0,0,0,0],
'lianova_veza_II':[0,0,0,0,0],
'kvetiny':[0,0,0]}

var collected_wisdom = {'les':[0,0,0,0,0],
'les_2':[0,0,0,0,0],
'Drotaverin':[0,0,0,0,0],
'les_3':[0,0,0,0,0],
'les_4':[0,0,0,0,0],
'strom':[0,0,0,0,0],
 'lad':[0,0,0,0,0], 
'ice_phase_2':[0,0,0,0,0],
 'lad_2':[0,0,0,0,0],
"tutorial":[0,0,0,0,0],
'les_5':[0,0,0,0,0],
'les_6':[0,0,0,0,0],
'les_7':[0,0,0,0,0],
'les_8':[0,0,0,0,0],
'les_9':[0,0,0,0,0],
'les_10':[0,0,0,0,0],
'les_11':[0,0,0,0,0],
'les_12':[0,0,0,0,0],
'les_13':[0,0,0,0,0],
'les_14':[0,0,0,0,0],
'les_15':[0,0,0,0,0],
'les_16':[0,0,0,0,0],
'les_17':[0,0,0,0,0],
'les_18':[0,0,0,0,0],
'les_19':[0,0,0,0,0],
'les_20':[0,0,0,0,0],
'F1':[0,0,0,0,0],
'S':[0,0,0,0,0],
'lianova_veza':[0,0,0,0,0],
'lianova_veza_II':[0,0,0,0,0],
'kvetiny':[0,0,0]}


var folk_wisdom = ['Nebude zo psa slanina, ani z vlka baranina.',
'Ťažko na cvičisku, ľahko na bojisku.',
'Nijaká kaša sa neje taká horúca, ako sa uvarí.',
'Všetko zlé je na niečo dobré.',
'Pomaly ďalej zájdeš.',
'Vrana k vrane sadá, rovný rovného si hľadá.',
'Nikomu nelietajú pečené holuby do úst.',
'Nechváľ deň pred večerom.',
'Kôň má štyri nohy a predsa potkne.',
'Skúsenosť je matka múdrosti.',
'Železo sa musí kuť za horúca.']
var reg_wisdom  = ['Chvála znamená tešiť sa z Boha',
'Peklo je keď vidíš pravdu že si zlý a je to tvoja vina pretože si sa mohol hľadať ale tebe stačil tento krátky život, a tak je všetko čo dostaneš. Už sa nič nedá spraviť.',
'Nebo je keď sa veci navrátia do stavu v akom mali byť. ľudia nebudú mať podvedomie a všetko čo zažiješ budeš vidieť navždy.',
'Kto chodí s múdrymi, ten zmúdrie (popri nich), druhovi bláznov sa však plano povodí. \n Pr 13:20',
'Zlo sa snaží z človeka spraviť aniela a pritom z neho spraví zviera. Z aniela Boha a pritom z neho spraví niečo podobné človeku. Zo zvieraťa človeka a spraví z neho rastlinu.',
'Keby ma otec i matka opustili, Hospodin by sa ma ujal. \n Ž 27:10',
'Ježiš vošiel do chrámu a vyhnal všetkých predavačov a kupujúcich v chráme. Peňazomencom poprevracal stoly a predavačom holubov stolice a povedal im: „Napísané je: »Môj dom sa bude volať domom modlitby.« A vy z neho robíte lotrovský pelech. \n Mt 21:12-13',
'On nás urobil súcich za služobníkov Novej zmluvy, a nie litery, ale Ducha; lebo litera zabíja, kým Duch oživuje. \n II Kor 3:6',
'Ako slobodní, ale nie takí, čo slobodu majú za prikrývku zloby, ale ako Boží služobníci. \n I Pt 2:16',
'Pán je Duch; a kde je Pánov Duch, tam je sloboda. \n II Kor 3:17']
var oth_wisdom = ['Ak niečo vyskúšaš a nebaví ťa to, aspoň vieš že ťa to nebaví a nestráviš dlhé chvíle rozmýšlaním nad tým aké by to bolo. \n Dušan Kadlec',
'Dobré veci sa strácajú pretože ich neviem udržať, nie pretože po nich netúžim. Nemám to po čom túžim, ale to čoho bolesť dokážem vydržať. \n Dušan Kadlec ',
'Bez bolesti by sme si nikdy nepriznali chyby a navždy zostali hlúpy. Pretože pravda je často bolestivá. \n CS Lewis',
'Často som ticho, keď vidím niečo zlé. Ale keď poviem čo si myslím ukáže sa že aj iný mlčali a súhlasia so mnou.',
'Všetko je jed a nič nie je bez jedu; iba dávka robí, že vec nie je jedom. \n Paracelzus',
'Keď berieme do úvahy ľudskú hlúposť, predsa len ľudia vedia veľa. \n Jean Rostand',
'Múdry človek mlčí o tom, čo nevie \n Sofokles',
'Nie je nič hlúpejšie ako chcieť byť zo všetkých najmúdrejší. \n La Rochefoucauld',
'Keby len staroba dávala múdrosti, bol by dubový klát najväčším mudrcom. \n K.Havlíček-Borovský',
'Ľahšie je byť múdry pre druhých ako pre seba. \n La Rochefoucauld']
var fab_wisdom = ['Kúpajúci sa chlapec\n Chlapcovi sa zažiadalo zaplávať si do rieky. Kamaráti ho varovali, že voda je veľmi hlboká, no on ich nepočúval. No len čo sa ponoril, zistil že voda je naozaj prihlboká. Veľmi sa naľakal. „Pomoc!“ kričal „Topím sa!“ Popri rieke stál akýsi človek so psom. Nahnevane sa pozrel na  chlapca. „Ty hlúpe decko!“ zvolal „Nevieš, aká je táto rieka nebezpečná? Pochábeľ jeden!“ „Prosím vás, pane,“ nariekal chlapec, lebo cítil že už klesá pod hladinu, „Nemohli by ste ma najprv vytiahnuť a až potom karhať?“',
'Dve nádoby\n Rieka bola rozvodnená a strhávala všetko so sebou. Na hladine sa bezmocne pohojdávali dve nádoby. Jedna bola z pevnej zliatiny kovov – mosadze – a druhá bola rovnako pekná, no nebola už taká pevná, lebo bola z hliny. „Poď sem a drž sa pri mne,“ pozvala mosadzná nádoba hlinenú. „Dám na teba pozor. Som veľmi silná, nič ma nerozbije. Môžem sa trochu preliačiť, ale to je všetko. No ty chúďatko. Viem aké sú hlinené hrnce krehké a ako ľahko sa rozbijú. Poď ku mne, budem ťa strážiť.“ „Ďakujem ti ale radšej nie,“ zavolala hlinená nádoba a držala sa od mosadznej čo najďalej. „Prečo?“ spýtala sa mosadzná nádoba dotknuto. „Prečo nechceš plávač po rieke so mnou?“ „Viem, že myslíš svoju ponuku dobre,“ vysvetľovala hlinená nádoba, rýchlo sa vzďaľujúc, „ale ty si oveľa tvrdšia ako ja. Trochu do mňa drgneš, a rosypem sa na tisíc kúskov.“',
'Chlapec a lieskovce\n Maškrtný chlapec uvidel na stole pohár s lieskovcami. Oblizol sa a prikradol k nemu. Vopchal dnu ruku a nabral si za plnú hrsť orieškov. „Lieskovce!“ zvolal roztopašne „strašne mi chutia!“ Chlapec si však nabral toľko orieškov, že nemohol vytiahnuť ruku z pohára. Začal kričať od zúrivosti. Potom sa zúfalo rozplakal. Ak oriešky pustí, bude môcť vytiahnuť ruku. Ake on tie oriešky tak veľmi chcel! Mládenec, čo sa prizeral, mu prispel doboru radou. „Nebuď taký nenásytný!“ povedal „naber si len polovicu orieškov a ruku z pohára ľahko vytiahneš.“',
'Líška a vrana\n Líška sa potulovala po lese a márne hľadala čosi pod zub. Deň plynul pomaly a ona bola veľmi hľadná. „Čo by som dala za pekný kúsok syra!“ vzdychla si túžobne. Práve stála pod stromom, a keď zdvihla hlavu a pozrela sa do jeho koruny, uvidela tam sedieť vranu, ktorá držala v zobáku kus syra. Líška si lačne oblízla jazyk. Musí nájsť spôsob ako ten syr dostať. „Ó ,vrana,“ povedala sladkým hlasom „aká si len krásna! Máš tak jemné čierne perie a zobák tak krásne vykrojený. A keby si tak...“ Líška sa odmlčala a obdivne pokrútila hlavou. Vrana zvedavo čakala čo líška povie. „A keby si tak,“ pokračoval líška, „mala aj tak krásny hlas, ako si krásna ty sama, bola by si kráľovnou medzi vtákmi.“ Vrane lískine slová nesmierne zalichotili, otvorila zobák a hlasno zakrákala, aby jej ukázala, že vie aj spievať. V tej chvíli syr vypadol zo zobáka. Líška ho schmatla a ušla preč.',
'Poľovník a drevorubač\n Poľovník vyzbrojený puškou nebojácne kráčal lesom a nahlas si opakoval, že hľadá leva, aby ho mohol zastreliť. V duši však nebol až taký smelý, len chcel, aby si to ľudia o ňom mysleli. Po dlhej chôdzi prišiel k drevorubačovi, čo stínal strom. Pristavil sa pri ňom. „Haló,“ zavolal „hľadám stopy leva. Neviete, kde by som ich našiel?“ Drevorubač zložil sekeru a prikývol. „Pravdaže,“ odvetil, „Poďte so mnou a ja vám ukážem nielen stopy, ale aj leva.“ Keď to poľovník počul, zbledol a roztriasli sa mu kolená. „N-n-nie, netreba,“ vyjachtal, obrátil sa a ponáhľal sa preč. „J-ja nehľadám l-l-leva, iba jeho stopy.“',
'Prasa a ovca\n Prasaťu sa raz podarilo ujsť z chlieva. Pripojilo sa k čriede oviec na lúke. Jedna ovca sa s prasaťom spriatelila a dovolila mu ostať s nimi. Potom však prišiel gazda. Keď uvidel prasa, schytil ho a niesol preč. „Vezmem ťa k mäsiarovi,“ povedal. V tej chvíli začalo prasa strašne kvíkať, mykalo sa a usilovalo ujsť. Pasúce ovce to veľmi prekvapilo. „Čo robíš taký krik?“ spýtala sa jedna z nich. „My takto nevyčíname, keď nás gazda berie preč.“ „Vy asi nie,“ zakvičalo prasa. „Ale odo mňa chce gazda oveľa viac ako od vás. Od vás chce len vlnu ale odo mňa chce mäso.“',
'Komár a býk\n Komár bol síce malý, no veľa si o sebe namýšľal. Jedného dňa, keď ustal z lietania, sadol si na roh obrovskému býkovi, ktorý sa pásol na lúke. Býk sa pásol, dobručkého komára si ani nevšimol. Komár si oddýchol na slniečku a nabral sily na ďaľšiu cestu. Skôr ako odletel, zdvorilo sa prihovoril býkovi: „Žiaľ, už musím odísť. Ďakujem, že si mi dovolil oddýchnuť si na tvojom rohu. Rád by som ešte ostal a porozprával sa s tebou, ale už naozaj musím ísť.“ „Mne je celkom jedno, čo urobíš,“ zaručal býk. „Nevšimol som si ťa, keď si prišiel, a nezbadám ani, že ťa nebude.“',
'Líška a hrozno\n Líška bežala cez pole v zlatistom slnečnom dni. Končisté uši mala nastražené, vetrila nosom, či nezachytí známky nebezpečenstva. Ľudia ju nemali radi. Zastala na kraji vinohradu. Po drevených koloch sa popínali stovky viničov. Z nich vyseli obrovské strapce šťavnatého hrozna. „Uchmatnem si jeden z nich, kým príde gazda,“ pomyslela si líška. Natiahla sa a chňapla po najbližšom strapci. Bol však privysoko. Vrčiac od zúrivosti, zacúvala, rozbehla sa, vyskočila do vzduchu a klapla mocnými čelušťami. Zasa minula! Vyla od zlosti a skúšala to znova a znova. Celú hodinu behala a skákala, no hrozno nedočiahla. Napokon sa vzdala a odtiahla preč. „Veď ja to hrozno vlastne vôbec nechcem,“ mrmlala si pre seba. „Určite je kyslé a zlé.“',
'Vlk a kôň\n Vlk šiel cez pole a obzeral sa okolo seba, akú čertovinu by mohol vyviesť. Šiel práve popri ovse, ktorý sa vlnil vo vánku. Zastal a začal vetriť, či nezacíti dáke drobné zviera, čo by mohol uloviť a zjesť. Nič živé však nezaňuchal, a tak sklamane tiahol ďalej. Po chvíli stretol koňa. Vlkovi sa zježili na chrbte chlpy a ticho zavrčal. No nahlas nepovedal nič, aby koňa nenahneval. Nenávidel síce všetky zvieratá, no nemal v úmysle pohnevať sa  s takým veľkým a silným tvorom. Namiesto toho prefíkaný vlk rozmýšľal, kao by sa koňovi votrel do prizne. Kútikom oka zazrel ovos, vlniaci sa vo vetre. „Pozri na ten krásny ovos,“ povedal koňovi, „videl som ťa prichádzať, a pretože viem že koňe ľúbia ovos, všetko som ti nechal. Však to bolo odo mňa pekné?“ „Mňa neobalamutíš.“ Odvetil kôň, na ktorého reči vôbec nezapôsobili, „Dobre viem, že vlky nežerú ovos. Keby ho žrali, dávno by tu nebolo ani steblo.“',
'Veštec\n V meste bol práve trhový deň. Všade boli rozložené stánky s tovarom od výmyslu  sveta. Uprostred hlúčika ľudí sedel veštec. Skvele sa mu darilo, lebo za peniaze predpovedal budúcnosť mužom a ženám, čo sa tisli okolo neho. Ľudia viseli na každom jeho slove. „Óch,“ a „ách,“ vykrikovali pri každej predpovedi človeka  stojaceho v ich strede.  K hľúčiku sa pridávalo čoraz viac mužov a žien a všetci chceli vedieť, čo ich čaká v budúcnosti. Zrazu sa cez zástup zaačal predierať akýsi chlapec. „Ostaň vzadu, chlapče,“ zvolal podráždene veštec. „Nemôžeš sa predbiehať. Musíš počkať, kým na teba nepríde rad, ak chceš počuť, čo má budúcnosť pre teba prichystané.“ „Nesiem vám novinu!“ dychčal chlapec. „Akú novinu?“ zamračil sa veštec. „Vykradli vám dom!“ volal chlapec, „Zlodeji odniesli všetko čo máte.“ „Čo to vravíš?“ zvolal všetec červený od zlosti. „Vykradli vás zlodeji!“ odvetil chlapec.  V tej chvíli veštec zabudol, načo stojí na trhovisku. Pretisol sa cez ľudí a bežal domov. Ľudia za ním udivene pozerali. „Čudné,“ povedal jeden z nich, „tvrdil, že vie, čo sa nám stane, ale sám sebe nepredpovedal, že mu vykradnú dom.“']

var folk_count = [0,0,0,0,0,0,0,0,0,0,0]
var reg_count = [0,0,0,0,0,0,0,0,0,0]
var oth_count = [0,0,0,0,0,0,0,0,0,0]
var fab_count = [0,0,0,0,0,0,0,0,0,0]

var plants = {'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0}
var sutre = {'bauxit':     0,'hematite':   0,'malachite':  0,'azurite':    0,'antimonite': 0,'gold':       0,'silver':     0,'zincite':    0,'uvarovite':  0,'opal':       0,}

var solution = [1,1,1]

var empty_plant_dict =  {'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0}
var extract_voda = {'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0}
var extract_alc = {'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0}
var extract_olej = {'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0}

var alcohol= 0
var purified_water = 0
var oil = 0
var caje =[1,1,1,1] #[0,0,0,0]

var AB_time_left = 0
var wind_ab_b = false

var drop_ice = [0,0,0]
var drop_earth = [0,0,0]
var drop_fire = [0,0,0]
var drop_wind = [0,0,0]

var smelted_bars = [0,0,0,0,0]
func _process(delta: float) -> void:
#	pr#int(plants)
	#print(treasures['les_9'])
	#print('MU'+(str(magic_unlocked)))
	#print(meele_bought)
	#print(content_to_save['level'])
	#print(necklaces_bought," ",meele_bought," ", magic_ice_upgrade," ",magic_earth_upgrade," ",magic_fire_upgrade," ",magic_wind_upgrade)
	#print(collected_wisdom['les_8'])
	#print(meele_variables)
	#print(folk_count)
	#print(plants)
	#print(purified_water,alcohol,oil)
	#print(caje)
	#print(necklaces_bought)
	#print(wind_ab_b)
	#print(AB_time_left)
	#print(sutre)
	#print(smelted_bars)
#	pr#int(meele_bought)
#	print(GameManager.food_bought)
	#print(magic_bought)
	pass
func _ready() -> void:
	for name in plants:
		plants[name] = 1000
	for name in sutre:
		sutre[name] += 100
	for i in range(5,21):
		#print('les_%s'%str(i))
		deadlist['les_%s'%str(i)] = range(25).map(func(_i): return 1)
	ui_manager = get_tree().current_scene.get_child(0)
	options =  [ui_manager.get_node('ItemCount'),ui_manager.get_node('health_ui'),ui_manager.get_node('equipment2'),ui_manager.get_node('log'),ui_manager.get_node('Upgrade_wisdom'),ui_manager.get_node('minimap'),ui_manager.get_node('world_map')]
	options_positions = [options[0].position,options[1].position,options[2].position,options[3].position,options[4].position,options[5].position,options[6].position]
	opened_options = [options[0].visible,options[1].visible,options[2].visible,options[3].visible,options[4].visible,options[5].visible,options[6].visible]
	#await get_tree().create_timer(0.2).timeout
	#update_item_ui_gm()
	
	#_load()
func register_dead_npc(level,pos,respawn_time):
	pass
#	deadlist[str(level)][pos]= 0
	#await get_tree().create_timer(respawn_time).timeout
	#deadlist[str(level)][pos]= 1
func register_treasure(level, pos):
	#print(treasures[str(level)])
	treasures[str(level)][pos] = 1
	#print(treasures[str(level)])
func register_wisdom(level,pos):
	collected_wisdom[str(level)][pos] = 1
	
func respawn_player(path):
	print(path)
	get_tree().change_scene_to_file(path)
	health = player.max_health*0.05
	shield = player.max_shield*0.05
	player.can_move = 1
	player.dead = 0
func npc_deadlist(level):
	return deadlist[str(level)]
# level transition function that remembers weapeons
# enemy dead list 
'''
func autosave():
	while !get_tree().current_scene.get_child(1).dead:
		await get_tree().create_timer(10).timeout
		#save()
		_save()
		#print("works")
'''
func save(ab_time_left):
	
	equiped_staff = player.magic_element
	equiped_meele = player.meele_element
	equiped_necklace = player.equiped_necklace
	health = player.health
	shield = player.shield
	weapreon_type = player.meele
	ui_manager = get_tree().current_scene.get_child(0)

	
	options =  [ui_manager.get_node('ItemCount'),ui_manager.get_node('health_ui'),ui_manager.get_node('equipment2'),ui_manager.get_node('log'),ui_manager.get_node('Upgrade_wisdom'),ui_manager.get_node('minimap'),ui_manager.get_node('world_map')]
	options_positions = [options[0].position,options[1].position,options[2].position,options[3].position,options[4].position,options[5].position,options[6].position]
	opened_options = [options[0].visible,options[1].visible,options[2].visible,options[3].visible,options[4].visible,options[5].visible,options[6].visible]
	content_to_save['options_positions'] = options_positions
	content_to_save['options_visible'] = opened_options
	if player:
		AB_time_left = ab_time_left
		print('gm tl ', ab_time_left)
func load_save():
	var magic_upgrades_total = [magic_ice_upgrade,magic_earth_upgrade,magic_fire_upgrade,magic_wind_upgrade]
	var UImanager = get_tree().current_scene.get_child(0)
	for i in range(4):
		#print('load')
		#print(magic_upgrades_total[i])
		if magic_upgrades_total[i] == 1:
			UImanager.get_child(2).get_child(0).get_child(i).get_child(1).color = 'e6c46d'
		elif magic_upgrades_total[i] == 2:
			UImanager.get_child(2).get_child(0).get_child(i).get_child(1).color = 'e6c46d'
			UImanager.get_child(2).get_child(0).get_child(i).get_child(2).color = 'e6c46d'
		elif magic_upgrades_total[i] == 3:
			UImanager.get_child(2).get_child(0).get_child(i).get_child(1).color = 'e6c46d'
			UImanager.get_child(2).get_child(0).get_child(i).get_child(2).color = 'e6c46d'
			UImanager.get_child(2).get_child(0).get_child(i).get_child(3).color = 'e6c46d'
			
			# hower text update
	ui_manager = get_tree().current_scene.get_child(0)
	options = [ui_manager.get_node('ItemCount'),ui_manager.get_node('health_ui'),ui_manager.get_node('equipment2'),ui_manager.get_node('log'),ui_manager.get_node('Upgrade_wisdom'),ui_manager.get_node('minimap'),ui_manager.get_node('world_map')]
	if options_positions != []:
		options[0].position = options_positions[0]
		options[1].position = options_positions[1]
		options[2].position = options_positions[2]
		options[3].position = options_positions[3]
		options[4].position = options_positions[4]
		options[5].position = options_positions[5]
		options[6].position = options_positions[6]
	
	var i = 0
	for is_open in opened_options:
		if is_open:
			options[i].show()
		i  += 1
	if get_parent().name != 'main':
		player = get_tree().current_scene.get_node('Player')
	if player:
		#print('load ab time reset')
		player.AB_timer_b = false
		player.reset_ab_timer()
	var S= [equiped_staff, equiped_meele, equiped_necklace, health, shield, weapreon_type, opened_options ] # opened options for ui
	#print('save '+str(S))
	return S
	
func enter_level(level_path):
	get_tree().change_scene_to_file(level_path)
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().current_scene.get_child(0).update_world_ui(level_path)


#func gain_coins(coins_gained: int):
#	coins += coins_gained
	#emit_signal("gained_coins", coins_gained)
	#print(coins)
	#var scene_ui_node = get_tree().get_child("UIManager")
	#scene_ui_node.get_child(0).text = coins

func pause_play():
	paused = !paused
	pause_menu.visible = paused
	
func pause_fr():
	get_tree().paused = true
func resume_fr():
	get_tree().paused = false
		
func resume():
	get_tree().paused = false
	pause_play()
	
func restart():
	score = 0

	get_tree().reload_current_scene()
	get_tree().paused = false
	pause_play()

func quit():
	get_tree().quit()
#func update_item_ui_gm():
#	while true:
		#get_tree().current_scene.get_child(0).update_items_ui()
		#await get_tree().create_timer(0.1).timeout
func update_log_info(text):
	get_tree().current_scene.get_child(0).update_log_info(text)

	#print(total_wisdom)

var save_location = "user://SaveFile.json"

var content_to_save = {
	'level':"res://scenes/levely/tutorial.tscn",
	'gold': 0,
	'resources':[0,0,0,0],
	'staff_levels': [0,0,0,0],
	'necklaces':[0,0,0,0,0,0,0,0],
	'magic_unlocked': false,
	'weapreon_type':1,
	'meele':[0,0,0,0],
	'magic_bought':[0,0,0,0],
	'food_bought':food_bought_def,
	'wisdom_points':0,
	'meele_variables':[8,2,2.5,1.1],
	'magic_variables':[5,1,500],
	'upgrades':0,
	'total_upgrades':0,
	'options_positions':[],
	'options_visible':[],
	'last_spawn':000,
	'meele_in_use':0,
	'magic_in_use':0,
	'necklace_in_use':0,
	'base_health':50,
	'base_shield':200,
	'package':false,
	'treasures':  {'les':[0,0,0,0,0],'les_2':[0,0,0,0,0],'Drotaverin':[0,0,0,0,0],'les_3':[0,0,0,0,0],'les_4':[0,0,0,0,0],'strom':[0,0,0,0,0],'lad':[0,0,0,0,0], 'ice_phase_2':[0,0,0,0,0],'lad_2':[0,0,0,0,0],"tutorial":[0,0,0,0,0],'les_5':[0,0,0,0,0],'les_6':[0,0,0,0,0],'les_7':[0,0,0,0,0],'les_8':[0,0,0,0,0],'les_9':[0,0,0,0,0],'les_10':[0,0,0,0,0],'les_11':[0,0,0,0,0],'les_12':[0,0,0,0,0],'les_13':[0,0,0,0,0],'les_14':[0,0,0,0,0],'les_15':[0,0,0,0,0],'les_16':[0,0,0,0,0],'les_17':[0,0,0,0,0],'les_18':[0,0,0,0,0],'les_19':[0,0,0,0,0],'les_20':[0,0,0,0,0],'F1':[0,0,0,0,0],'S':[0,0,0,0,0],'lianova_veza':[0,0,0,0,0],'lianova_veza_II':[0,0,0,0,0],'kvetiny':[0,0,0]},
	'collected_wisdom':  {'les':[0,0,0,0,0],'les_2':[0,0,0,0,0],'Drotaverin':[0,0,0,0,0],'les_3':[0,0,0,0,0],'les_4':[0,0,0,0,0],'strom':[0,0,0,0,0],'lad':[0,0,0,0,0], 'ice_phase_2':[0,0,0,0,0],'lad_2':[0,0,0,0,0],"tutorial":[0,0,0,0,0],'les_5':[0,0,0,0,0],'les_6':[0,0,0,0,0],'les_7':[0,0,0,0,0],'les_8':[0,0,0,0,0],'les_9':[0,0,0,0,0],'les_10':[0,0,0,0,0],'les_11':[0,0,0,0,0],'les_12':[0,0,0,0,0],'les_13':[0,0,0,0,0],'les_14':[0,0,0,0,0],'les_15':[0,0,0,0,0],'les_16':[0,0,0,0,0],'les_17':[0,0,0,0,0],'les_18':[0,0,0,0,0],'les_19':[0],'les_20':[0,0,0,0,0],'F1':[0,0,0,0,0],'S':[0,0,0,0,0],'lianova_veza':[0,0,0,0,0],'lianova_veza_II':[0,0,0,0,0],'kvetiny':[0,0,0]},
	'folk_count' : [0,0,0,0,0,0,0,0,0,0,0],
	'reg_count' : [0,0,0,0,0,0,0,0,0,0],
	'oth_count' : [0,0,0,0,0,0,0,0,0,0],
	'fab_count' : [0,0,0,0,0,0,0,0,0,0],
	'plants':{'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0},
	'sutre':{'bauxit':     0,'hematite':   0,'malachite':  0,'azurite':    0,'antimonite': 0,'gold':       0,'silver':     0,'zincite':    0,'uvarovite':  0,'opal':       0,},
	'extrakty': [empty_plant_dict, empty_plant_dict, empty_plant_dict],
	'caje':[0,0,0,0],
	'drop_ice' : [0,0,0],
	'drop_earth' :[0,0,0],
	'drop_fire' : [0,0,0],
	'drop_wind' : [0,0,0],
	'smelted_bars' : [0,0,0,0,0]
	}

func _reset():
	content_to_save = {
	'level':'res://scenes/levely/tutorial.tscn',
	'gold': 0,
	'resources':[0,0,0,0],
	'staff_levels': [0,0,0,0],
	'necklaces':[0,0,0,0,0,0,0,0],
	'magic_unlocked': false,
	'weapreon_type':1,
	'meele':[0,0,0,0],
	'magic_bought':[0,0,0,0],
	'food_bought':food_bought_def,
	'wisdom_points':0,
	'meele_variables':[8,2,2.5,1.1],
	'upgrades':0,
	'total_upgrades':0,
	'magic_variables':[5,1,500],
	'options_positions':[],
	'options_visible':[],
	'last_spawn':000,
	'meele_in_use':0,
	'magic_in_use':0,
	'necklace_in_use':0,
	'base_health':50,
	'base_shield':200,
	'package':false,
	'treasures':  {'les':[0,0,0,0,0],'les_2':[0,0,0,0,0],'Drotaverin':[0,0,0,0,0],'les_3':[0,0,0,0,0],'les_4':[0,0,0,0,0],'strom':[0,0,0,0,0],'lad':[0,0,0,0,0], 'ice_phase_2':[0,0,0,0,0],'lad_2':[0,0,0,0,0],"tutorial":[0,0,0,0,0],'les_5':[0,0,0,0,0],'les_6':[0,0,0,0,0],'les_7':[0,0,0,0,0],'les_8':[0,0,0,0,0],'les_9':[0,0,0,0,0],'les_10':[0,0,0,0,0],'les_11':[0,0,0,0,0],'les_12':[0,0,0,0,0],'les_13':[0,0,0,0,0],'les_14':[0,0,0,0,0],'les_15':[0,0,0,0,0],'les_16':[0,0,0,0,0],'les_17':[0,0,0,0,0],'les_18':[0,0,0,0,0],'les_19':[0,0,0,0,0],'les_20':[0,0,0,0,0],'F1':[0,0,0,0,0],'S':[0,0,0,0,0],'lianova_veza':[0,0,0,0,0],'lianova_veza_II':[0,0,0,0,0],'kvetiny':[0,0,0]},
	'collected_wisdom':  {'les':[0,0,0,0,0],'les_2':[0,0,0,0,0],'Drotaverin':[0,0,0,0,0],'les_3':[0,0,0,0,0],'les_4':[0,0,0,0,0],'strom':[0,0,0,0,0],'lad':[0,0,0,0,0], 'ice_phase_2':[0,0,0,0,0],'lad_2':[0,0,0,0,0],"tutorial":[0,0,0,0,0],'les_5':[0,0,0,0,0],'les_6':[0,0,0,0,0],'les_7':[0,0,0,0,0],'les_8':[0,0,0,0,0],'les_9':[0,0,0,0,0],'les_10':[0,0,0,0,0],'les_11':[0,0,0,0,0],'les_12':[0,0,0,0,0],'les_13':[0,0,0,0,0],'les_14':[0,0,0,0,0],'les_15':[0,0,0,0,0],'les_16':[0,0,0,0,0],'les_17':[0,0,0,0,0],'les_18':[0,0,0,0,0],'les_19':[0,0,0,0,0],'les_20':[0,0,0,0,0],'F1':[0,0,0,0,0],'S':[0,0,0,0,0],'lianova_veza':[0,0,0,0,0],'lianova_veza_II':[0,0,0,0,0],'kvetiny':[0,0,0]},
	'folk_count' : [0,0,0,0,0,0,0,0,0,0,0],
 	'reg_count' : [0,0,0,0,0,0,0,0,0,0],
 	'oth_count' : [0,0,0,0,0,0,0,0,0,0],
 	'fab_count' : [0,0,0,0,0,0,0,0,0,0],
	'plants':{'mata':0,'salvia':0,'divozel':0,'slez':0,'mak':0,'skorocel':0,'pupava':0,'nevadza':0,'cakanka':0,'hluchavka':0,'alchemilka':0,'zihlava':0,'trezalka':0,'marinka':0,'prvosienky':0,'cesnak':0,'konvalinka':0,'jesienka':0},
	'sutre':{'bauxit':     0,'hematite':   0,'malachite':  0,'azurite':    0,'antimonite': 0,'gold':       0,'silver':     0,'zincite':    0,'uvarovite':  0,'opal':       0,},
	'extrakty': [empty_plant_dict, empty_plant_dict, empty_plant_dict],
	'caje':[0,0,0,0],
	'drop_ice' : [0,0,0],
	'drop_earth' :[0,0,0],
	'drop_fire' : [0,0,0],
	'drop_wind' : [0,0,0],
	'smelted_bars' : [0,0,0,0,0]
	}
func _save(last_spawn:= 000 ):
	content_to_save['gold'] = gold
	content_to_save['resources'] = [deepfrost,livingwood,ash,windsteel]
	content_to_save['staff_levels'] = [magic_ice_upgrade,magic_earth_upgrade,magic_fire_upgrade,magic_wind_upgrade]
	content_to_save['magic_unlocked'] = magic_unlocked
	content_to_save['weapreon_type'] = weapreon_type
	content_to_save['necklaces'] = necklaces_bought
	content_to_save['meele'] = meele_bought 
	content_to_save['magic_bought'] = magic_bought 
	content_to_save['food_bought'] =food_bought
	content_to_save['wisdom_points'] = wisdom_points
	content_to_save['meele_variables'] = meele_variables
	content_to_save['upgrades'] = wisdom_upgrade
	content_to_save['magic_variables'] = magic_variables
	content_to_save['package'] = package
	content_to_save['last_spawn'] = player_spawn
	content_to_save['meele_in_use'] = equiped_meele
	content_to_save['magic_in_use'] = equiped_staff
	content_to_save['necklace_in_use'] = equiped_necklace
	content_to_save['base_health'] = base_health
	content_to_save['base_shield'] = base_shield
	content_to_save['total_upgrades'] = wisdom_upgrade_level
	content_to_save['treasures'] = treasures
	content_to_save['collected_wisdom'] = collected_wisdom
	content_to_save['folk_count'] = folk_count
	content_to_save['reg_count'] = reg_count
	content_to_save['oth_count'] = oth_count
	content_to_save['fab_count'] = fab_count
	content_to_save['plants'] = plants
	content_to_save['sutre'] = sutre
	content_to_save['extrakty']=  [extract_voda, extract_alc, extract_olej]
	content_to_save['caje'] = caje
	content_to_save['drop_ice'] = drop_ice
	content_to_save['drop_earth'] =drop_earth
	content_to_save['drop_fire'] = drop_fire
	content_to_save['drop_wind'] = drop_wind
	content_to_save['smelted_bars'] = smelted_bars
	var File = FileAccess.open(save_location,FileAccess.WRITE)
	File.store_var(content_to_save.duplicate())
	File.close()
	
func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location,FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		gold = save_data['gold']
		deepfrost = save_data['resources'][0]
		livingwood = save_data['resources'][1]
		ash = save_data['resources'][2]
		windsteel =save_data['resources'][3]
		magic_ice_upgrade = save_data['staff_levels'][0]
		magic_earth_upgrade = save_data['staff_levels'][1]
		magic_fire_upgrade = save_data['staff_levels'][2]
		magic_wind_upgrade = save_data['staff_levels'][3]
	#	magic_unlocked = save_data['magic_unlocked']
		weapreon_type = save_data['weapreon_type']
		#necklaces_bought = save_data['necklaces']
		current_level_path = save_data['level']
	#	meele_bought = save_data['meele']
		#magic_bought = save_data['magic_bought']
		
		wisdom_points = save_data['wisdom_points']
		meele_variables = save_data['meele_variables']
		wisdom_upgrade = save_data['upgrades']
		wisdom_upgrade_level = save_data['total_upgrades']
		magic_variables = save_data['magic_variables']
		#opened_options = save_data['options_visible']
	#	options_positions = save_data['options_positions']
		player_spawn = save_data['last_spawn']
		equiped_meele = save_data['meele_in_use']
		equiped_staff = save_data['magic_in_use']
		equiped_necklace = save_data['necklace_in_use']
		base_health = save_data['base_health']
		base_shield = save_data['base_shield']
		package = save_data['package']
		treasures = save_data['treasures']
		collected_wisdom = save_data['collected_wisdom']
		folk_count = save_data['folk_count']
		reg_count = save_data['reg_count']
		oth_count = save_data['oth_count']
		fab_count = save_data['fab_count']
		#plants = save_data['plants']		
		#sutre= save_data['sutre']
		extract_voda= save_data['extrakty'][0]
		extract_alc= save_data['extrakty'][1]
		extract_olej = save_data['extrakty'][2]
	#	caje = save_data['caje']
	#	food_bought = save_data['food_bought']
		#drop_ice = save_data['drop_ice']
		#drop_earth  =save_data['drop_earth']
		#drop_fire= save_data['drop_fire']
		#drop_wind =save_data['drop_wind']
		#smelted_bars = save_data['smelted_bars'] 
		
		#print(player_position_save)
		load_save()
		return save_data
		
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func register_count(type, pos):
	if type == 'folk':
		folk_count[pos] = 1
	elif type == 'reg':
		reg_count[pos] = 1
	elif type == 'oth':
		oth_count[pos] = 1
	elif type == 'fab':
		fab_count[pos] = 1

func equip_magic_to_player():
	print(player)
	player.magic_weapeon_equip(equiped_staff)
	
	
