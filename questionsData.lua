--[[
	Author: FileEX
]]
local questions = {
	[1] = { -- Etap I
		{'Jaki sport uprawia Arkadiusz Milik?', {'Piłka nożna', 'Piłka ręczna', 'Siatkówka', 'Koszykówka'}, {1,0,0,0}},
		{'Ile królowych matek jest w jednym ulu?', {'1', 'Dowolna ilość', '2', '0'}, {1,0,0,0}},
		{'Jak nazywała się żona Adolfa Hitlera?', {'Maria Braun', 'Ewa Braun', 'Angela Koperfield', 'Ewa Hitler'}, {0,1,0,0}},
		{'W jakim Polskim mieście działa Uniwersytet Muzyczny im. Fryderyka Chopina?', {'W Krakowie','We Wrocławiu','W Warszawie','W Katowicach'},{0,0,1,0}},
		{'Jak z języka francuskiego nazywa się karta dań podawana w restauracjach?', {'Menu','Carte au restaurant','À la cantine','Carte'},{1,0,0,0}},
		{'Od którego roku Polska jest członkiem Światowej Organizacji Handlowej?', {'1985','1990','1995','1999'}, {0,0,1,0}},
		{'Gdzie leży pustynia Błędowska?', {'Na południu Polski', 'Na północy Polski', 'Na zachodzie Polski', 'Na wschodzie Polski'}, {1,0,0,0}},
		{'Jak nazywa się horobliwa żądza podpalania?', {'Piromania', 'Ogniomania', 'Pirotechnika', 'Prochomania'}, {1,0,0,0}},
		{'Co pochwalał Erazm z Rotterdamu w jednym ze swoich dzieł?', {'Pychę', 'Głupotę', 'Powagę', 'Mądrość'}, {0,1,0,0}},
		{'Jak nazywało się plemie wojowniczych kobiet, którego królową była Hipolita?', {'Amazonki', 'Indianki', 'Husarki', 'Majówki'}, {1,0,0,0}},
		{'Premierem jakiego państwa był Ariel Szaron?', {'Włoch', 'Egiptu', 'Izraela', 'Syrii'}, {0,0,1,0}},
		{'Jak nazywa się podręcznik do początkowej nauki czytania i pisania?', {'Słownik', 'Encyklopedia', 'Elementarz', 'Podręcznik do kaligrafii'}, {0,0,1,0}},
		{'Co to jest arkebuz?', {'Odmiana arbuza', 'Broń palna', 'Broń biała', 'Owoc cytrusowy'}, {0,1,0,0}},
		{'Jak miała na imię żona Karwowskiego w serialu "Czterdziestolatek"?', {'Magda','Helena','Maria','Marta'},{1,0,0,0}},
		{'Na fladze jakiego państwa widnieje półksiężyc?', {'Tunezji', 'Turcji', 'Żadnego', 'Tajlandii'}, {0,0,1,0}},
		{'Z ilu dźwięków w oktawie składa się pentatonika?', {'z 3', 'z 2', 'z 7', 'z 5'}, {0,0,0,1}},
		{'W którym roku odbyły się obrady okrągłego stołu?', {'1999', '1989', '1985', '1994'}, {0,1,0,0}},
		{'Co to jest pumpernikiel?', {'Jasne pieczywo', 'Ciemne pieczywo', 'Bardzo ciemne pieczywo', 'Rodzaj wypieku'}, {0,0,1,0}},
		{'Jak nazywa się półwysep, na którym leżą Włochy?', {'Apeniński', 'Arabski', 'Europejski', 'Helski'}, {1,0,0,0}},
		{'W wierszu Jana Brzechwy na stoliczku stał koszyczek, a w nim jabłuszko. Kto mieszkał w jabłuszku?', {'Plastuś', 'Pesteczka', 'Robaczek', 'Tomek'}, {0,0,1,0}},
		{'Jaki jest wzór chemiczny lodu?', {'H2NO3','H2O','H2SO4','HCL'}, {0,1,0,0}},
		{'Ile ósemek trwa półnuta?', {'8','2','4','5'}, {0,0,1,0}},
		{'Trzech Polaków zdobyło wszystkie ośmiotysięczne szczyty na ziemi. Wskaż jednego z nich.', {'Ryszard Pawłowski','Wanda Rutkiewicz','Krzysztof Wielicki','Piotr Pustelnik'}, {0,0,1,0}},
		{'Jak rzekomo okaleczały się Amazonki, by móc lepiej strzelać z łuku?', {'Nacinały dłonie', 'Odcinały prawą pierś', 'Odcinały piersi', 'Odrywały paznokcie'}, {0,1,0,0}},
		{'Czego pełna była rzeka, o której śnił kotek w wierszu Juliana Tuwima?', {'Czekolady', 'Wody', 'Mleka', 'Rybek'}, {0,0,1,0}},
		{'Jaka jest najmniejsza liczba całkowita, większa od liczby π (PI)?', {'3','3,5','4','2'}, {0,0,1,0}},
		{'Które państwo jest ojczyzną jedwabu?', {'Chiny', 'Tajlandia', 'Indie', 'Japonia'}, {1,0,0,0}},
		{'Na terytorium jakiego państwa leży terytorium dawnego królestwa Neapolu?', {'Hiszpanii', 'Portugalii', 'Grecji', 'Włoch'}, {0,0,0,1}},
		{'Jak brzmi polska nazwa organizacji NATO?', {'Organizacja Narodów Zjednoczonych', 'Pakt Pólnocno-Atlantycki', 'Narodowa Anty-Totalitarna\nOrganizacja', 'Traktat Pokojowy'}, {0,1,0,0}},
		{'Ilu komórkowym zwierzęciem jest meduza?', {'Jedno', 'Dwu', 'Cztero', 'Wielokomórkowym'}, {0,0,0,1}},
		{'W jakich górach leży dolina za mnichem?', {'W Tatrach', 'W Alpach', 'W Himalajach', 'W Karpatach'}, {1,0,0,0}},
		{'Kto jest twórcą Pana Kleksa?', {'Jan Brzechwa', 'Julian Tuwim', 'Kornel Makuszyński', 'Bolesław Leśmian'}, {1,0,0,0}},
		{'"Cztery kółka" to określenie którego środka lokomocji?', {'Pociągu','Autobusu','Samochodu','Quada'}, {0,0,1,0}},
		{'Na jakim zwierzęciu Chrystus wjechał triumfalnie do Jerozolimy?', {'Na koniu', 'Na wielbłądzie', 'Na osiołku', 'Na słoniu'}, {0,0,1,0}},
		{'Jak nazywa się rzeka płynąca na terenie Polski, Ukrainy i Białorusi? Jest długa na ok. 800km.', {'Wołga', 'Wisła', 'Bug', 'Narew'}, {0,0,1,0}},
		{'Co można zrobić z laudacją?', {'Wypić', 'Odwołać', 'Wygłosić', 'Nałożyć'}, {0,0,1,0}},
		{'Carpaccio to danie kuchni:', {'Francuskiej', 'Włoskiej', 'Hiszpańskiej', 'Portugalskiej'}, {0,1,0,0}},
		{'Czego nie ma w sosie bearnaise?', {'Żółtek jaj', 'Masła', 'Oliwy z oliwek', 'Octu'}, {0,0,1,0}},
		--{'', {}, {}},
	},
	[2] = { -- Etap II
		{'Co to jest mufin?', {'Rodzaj ciastka', 'Gra planszowa', 'Część damskiej garderoby', 'Rodzaj kapelusza'}, {1,0,0,0}},
		{'Jak zginął król Francji, Ludwik XVI?', {'Został spalony', 'Został przebity mieczem', 'Został powieszony', 'Został zgilotynowany'}, {0,0,0,1}},
		{'Dopływem której rzeki jest Brda?', {'Odry', 'Wisły', 'Warty', 'Narewu'}, {0,1,0,0}},
		{'Jakiego koloru odcieniami są cynober i karmin?', {'Zielonego', 'Fioletowego', 'Czerwonego', 'Niebieskiego'}, {0,0,1,0}},
		{'Jaką biblijną postać nazywa się królową niebios?', {'Matkę Boską', 'Maryję', 'Marię', 'Anna'}, {1,0,0,0}},
		{'W jakiej miejscowości nad jeziorem Gopło stoi wierza, w której wg. legendy myszy zjadły popielca?', {'Grodztwo', 'Kobylniki', 'Łagiewniki', 'Kruszwica'}, {0,0,0,1}},
		{'Jakiej narodowści jest piosenkarz Hulio Iglessias?', {'Portugalskiej', 'Hiszpańskiej', 'Argentyńskiej', 'Włoskiej'}, {0,1,0,0}},
		{'Gigaherc ile to herców?', {'sto', 'tysiąc', 'sto tysięcy', 'miliard'}, {0,0,0,1}},
		{'Którą konkurencję uprawia Piotr Małachowski?', {'Rzut dyskiem', 'Rzut młotem', 'Pchnięcie kulą', 'Rzut oszczepem'}, {1,0,0,0}},
		{'Na którym kontynencie żył Francesco Petrarca?', {'Europa', 'Azja', 'Ameryka Środkowa', 'Ameryka Południowa'}, {1,0,0,0}},
		{'Kto to jest werbista?', {'Muzyk grający na werblach', 'Zakonnik', 'Dawniej szewc', 'Specjalista od perkusji'}, {0,1,0,0}},
		{'Jak nazywał się książe siedmiogrodu, który w XVI wieku został królem Polski?', {'Kazimierz Wielki', 'Zygmunt Stary', 'Stefan Batory', 'Władysław Łokietek'}, {0,0,1,0}},
		{'Czym jest empiryzm?', {'Tezą', 'Doświadczeniem', 'Hipotezą', 'Stwierdzeniem'}, {0,1,0,0}},
		{'Do jakiego miasta trafiły po śmierci Zdzisława Beksińskiego, na mocy jego testamentu prace artysty?', {'Warszawy', 'Krakowa', 'Sanoka', 'Wrocławia'}, {0,0,1,0}},
		{'Na jakim oceanie znajduje się archipelag Riukiu?', {'Atlantyckim', 'Spokojnym', 'Indyjskim', 'Arktyczny'}, {0,1,0,0}},
		{'Jak nazywa się zespół liczb ustawionych w postaci kwadratowej tablicy, w której sumy liczb w każdym wierszu, kolumnie i przekątnych są jednakowe?', {'Ciąg','Macierz','Kwadrat magiczny','Potęga'}, {0,0,1,0}},
		{'W którym wieku tworzył Michaił Szołochow?', {'XIV', 'XV', 'XVIII', 'XX'}, {0,0,0,1}},
		{'Jak nazywa się antynagroda przyznawana najgorszym filmom?', {'Oscar', 'Złote maliny', 'Darwina', 'Złoty glob'}, {0,1,0,0}},
		{'Jakiego pochodzenia jest bawełna?', {'Zwierzęcego', 'Roślinnego', 'Wytwarzana przez człowieka', 'Chemicznego'}, {0,1,0,0}},
		{'Który z tych głosów jest rodzaju żeńskiego?', {'Baryton', 'Bas', 'Alt', 'Kontratenor'}, {0,0,1,0}},
		{'Ajschylos i Sofokles to dwóch z trójki wielkich tragików. Jak nazywa się trzeci Ateński tragik?', {'Herakles', 'Eurypides', 'Arystofanes', 'Ion'}, {0,1,0,0}},
		{'Jaką literą oznacza się przyśpieszenie ziemskie w fizyce?', {'F', 'T', 'G', 'V'}, {0,0,1,0}},
		{'Częścią jakiego miasta są Łabędy?', {'Gdańska', 'Koszalina', 'Gliwic', 'Grudziądza'}, {0,0,1,0}},
		{'W jakim państwie miał miejsce kryzys polityczny spowodowany tzw. Sprawą Drejfusa pod koniec XIX wieku?', {'W Austrii', 'We Włoszech', 'We Francji', 'W Wielkiej Brytanii'}, {0,0,1,0}},
		{'Co znaczy skrót OBWE?', {'Obrady Belgijskich Wojsk Europejskich', 'Okaz Broni Wojsk Europejskich', 'Organizacja Bezpieczeństwa\nWewnętrznego Europy', 'Organizacja Bezpieczeństwa\ni Współpracy w Europie'}, {0,0,0,1}},
		{'Gdzie mieści się siedziba Organizacji Bezpieczeństwa i Współpracy w Europie?', {'W Brukseli', 'W Pradze', 'W Wiedniu', 'W Berlinie'}, {0,0,1,0}},
		{'Przez jaki ocean płyną ciepłe wody golfsztromu?', {'Spokojny', 'Atlantycki', 'Indyjski', 'Arktyczny'}, {0,1,0,0}},
		{'W jakim państwie przyznawany jest order Jarosława Mądrego?', {'W Rosji', 'Na Ukrainie', 'Na Białorusi', 'W Niemczech'}, {0,1,0,0}},
		{'Jak nazywa się aktorka, która zagrała w Killerze dziennikarkę Ewę Szańską?', {'Małgorzata Korzuchowska', 'Anna Przybylska', 'Katarzyna Figura', 'Joanna Kulig'}, {1,0,0,0}},
		{'W jakim państwie znajduje się puszcza Biskupia?', {'W Niemczech', 'W Polsce', 'W Czechach', 'Na Słowacji'}, {0,1,0,0}},
		{'Japonia podpisała akt bezwarunkowej kapitulacji w 1945 roku. W którym miesiącu?', {'Październik', 'Wrzesień', 'Sierpień', 'Listopad'}, {0,1,0,0}},
		{'Dlaczego królowa Polski Jadwiga, żona Jagiełły nie nosiła krynoliny?', {'Nie podobała jej się', 'Nie była już modna', 'Nie powstała jeszcze', 'Nosiła ją'}, {0,0,1,0}},
		{'Kim był Antystenes?', {'Cynikiem', 'Sofistą', 'Tragikiem', 'Bogiem'}, {1,0,0,0}},
		{'W jakiej dziedzinie Maria i Piotr Currie dostali w 1903 roku nagrodę Nobla?', {'Chemii', 'Fizyki', 'Filozofii', 'Sztuki'}, {0,1,0,0}},
		{'Jak nazywa się wijąca droga po zboczu góry?', {'Serpentyna', 'Zawijka', 'Szlak', 'Zawijanka'}, {1,0,0,0}},
		{'Który król Angielski wydał w 1215 roku Wielką Kartę Swobód?', {'Henryk IV', 'Henryk VI', 'Jan bez Ziemi', 'Henryk III Plantagenet'}, {0,0,1,0}},
		{'Nad jaką rzeką leży Jelenia Góra?', {'Nad Odrą', 'Nad Wisłą', 'Nad Bobrem', 'Nad Narewem'}, {0,0,1,0}},
		{'Królem którego Greckiego państwa-miasta był Leonidas? Poległy w bitwie pod Termopilami.', {'Aten', 'Sparty', 'Trypolisu', 'Agory'}, {0,1,0,0}},
		{'W 2006 roku Pluton stracił status planety. Jaka planeta jest obecnie najmniejsza w układzie słonecznym?', {'Mars','Jowisz','Saturn','Merkury'}, {0,0,0,1}},
		{'Pytanie muzyczne\nTa kompozycja Henryka Wieniawskiego to...?', {'Kujawiak', 'Oberek', 'Polonez', 'Krakowiaczek'}, {1,0,0,0}, '200'},
		{'Tematyka którego regionu Polski dominuje w twórczości Gustawa Morcinka?', {'Mazur', 'Kaszub', 'Śląska', 'Pomorza'}, {0,0,1,0}},
		{'W jakim muzeum można oglądać Kamień Rosetty?', {'W Paryżu', 'W Krakowie', 'W Londynie', 'W Moskwie'}, {0,0,1,0}},
		{'Jaka dyscyplina sportowa jest oznaczana skrótem MTB?', {'Koszykówka', 'Hokej', 'Tenis', 'Kolarstwo Górskie'}, {0,0,0,1}},
		{'W jakim mieście Holandii obraduje parlament tego państwa?', {'Amsterdam', 'Haga', 'Utrecht', 'Rotterdam'}, {0,1,0,0}},
		{'W jakiej porze roku obchodzony jest dzień Świętego Mikołaja?', {'Zimą', 'Wiosną', 'Jesienią', 'Latem'}, {0,0,1,0}},
		{'Jaki sport uprawia bohaterka filmu Clint\'a Eastwood\'a "Za Wszelką Cenę"?', {'Tenis', 'Golf', 'Boks', 'Karate'}, {0,0,1,0}},
		{'Z jakiego języka pochodzi słowo "demokracja", które znaczy władza?', {'Grekciego', 'Włoskiego', 'Łacińskiego', 'Angielskiego'}, {1,0,0,0}},
		{'Jaki gaz ma najniższą temperaturę skraplania?', {'Azot', 'Ozon', 'Hel', 'Tlen'}, {0,0,1,0}},
		{'Kofi Annan, Ban Ki Moon i Kurt Waldheim pełnili urząd sekretarza generalnego jakiej organizacji?', {'NATO','ONZ','Czerwony Krzyż','UNESCO'}, {0,1,0,0}},
		{'Ile dni ma senat na rozpatrzenie i zatwierdzenie lub odrzucenie ustawy sejmowej?', {'7','14','30','4'}, {0,0,1,0}},
		{'Z czyich bajek wywodzi się powiedzenie "Dom się powalił, a trzcina została."?', {'Krasickiego', 'Leśmiana', 'Ezopa', 'Tuwima'}, {0,0,1,0}},
		{'Jaki święty jest patronem alpinistów?', {'Florian', 'Wojciech', 'Józef', 'Bernard'}, {0,0,0,1}},
		{'W których letnich igrzyskach olimpijskich uczestniczyło najmniej reprezentacji narodowych?', {'W Monachium', 'W Moskwie', 'W Montrealu', 'W Tokio'}, {0,1,0,0}},
		{'Jak nazywały się oddziały piechoty utworzone przez Stefana Batorego z chłopów pochodzących z dóbr królewskich?', {'Ułani', 'Kosynierzy', 'Piechota Wybraniecka', 'Kułaki'}, {0,0,1,0}},
		{'Jaki kwas znajduje się w żołądku u człowieka?', {'Mlekowy', 'Siarkowodorowy', 'Solny', 'Askorbinowy'}, {0,0,1,0}},
		--{'', {}, {}},

		{'Pytanie muzyczne\nJaki zespół jest wykonawcą tego utworu?', {'Perfect', 'Lady Pank', 'SDM', 'Skaldowie'}, {1,0,0,0}, '201'},
	},
	[3] = { -- Etap III
		{'Gdzie leży Dolina Krzemowa?', {'W Tatrach', 'W Kalifornii', 'W Atenach', 'W Chicago'}, {0,1,0,0}},
		{'Jakie imię nosił Fahrenheit? Wynalazca termometru rtęciowego.', {'Daniel Gabriel', 'Michaił Gabriel', 'Daniel Michaił', 'Mark Ben'}, {1,0,0,0}},
		{'Jakie państwo zaatakowało Finlandię w czasie tzw. Wojny Zimowej?', {'Niemcy', 'ZSRR', 'USA', 'Włochy'}, {0,1,0,0}},
		{'Jak nazywa się artysta rzeźbiący w drewnie?', {'Stolarz', 'Rusznikarz', 'Snycerz', 'Kuśnierz'}, {0,0,1,0}},
		{'W jakim mieście ma siedzibę Angielski klub piłkarski Arsenal?', {'Chicago', 'Londyn', 'Birmingham', 'Leeds'}, {0,1,0,0}},
		{'Dla wyznawców których religii Jerozolima jest miastem Świętym?', {'Chrześcijaństwa,Judaizmu,Buddyzmu','Islamu,Buddyzmu,Judaizmu', 'Chrześcijaństwa,Islamu,Judaizmu', 'Buddyzmu,Judaizmu,Chrześcijaństwa'}, {0,0,1,0}},
		{'Jak nazywał się w mitologii Greckiej pokarm Bogów, który dawał im nieśmiertelność?', {'Karma', 'Nektar', 'Ambrozja', 'Zioła'}, {0,0,1,0}},
		{'Co znaczy "Secesja"?', {'Oddzielenie', 'Przyłączenie', 'Odłączenie', 'Uroczystość podarowania ziem'}, {1,0,0,0}},
		{'W którym roku miał miejsce chrzest Polski?', {'1900', '986', '966', '1000'}, {0,0,1,0}},
		{'Jaką funkcję Ignacy Żecki pełnił w sklepie Stanisława Wokulskiego?', {'Sprzedawca', 'Magazynier', 'Ochroniarz', 'Księgowy'}, {1,0,0,0}},
		{'Z jaką maksymalną prędkością można jeździć po Polskich autostradach?', {'120 km/h', '140 km/h', '160 km/h', '180 km/h'}, {0,1,0,0}},
		{'Gdzie zmarła królowa Bona Sforza?', {'W Polsce', 'We Francji', 'We Włoszech', 'W Niemczech'}, {0,0,1,0}},
		{'Z jakiego państwa pochodzi malarz Diego Velascess?', {'Z Włoch', 'Z Francji', 'Z Hiszpanii', 'Z Grecji'}, {0,0,1,0}},
		{'Bohaterami którego opowiadania Stefana Żeromskiego są Stanisława Bozowska i Paweł Obarecki?', {'Echa Leśne', 'Siłaczka', 'Ludzie bezdomni', 'Zmierzch'}, {0,1,0,0}},
		{'Jarmuż to odmiana jakiego warzywa?', {'Ziemniaka', 'Kapusty', 'Cukinii', 'Buraka'}, {0,1,0,0}},
		{'Jakie pokrewieństwo łączy aktorki Krystynę Jandę i Marię Seweryn?', {'Rodzeństwo', 'Matka i Córka', 'Kuzynostwo', 'Przyjaciółki'}, {0,1,0,0}},
		{'Jak nazywa się uchwała parlamentu wyrażająca negatywną ocenę działalności rządu, która zobowiązuje premiera albo ministra do podania się do dymisji?', {'Liberum veto', 'Votum', 'Votum Nieufności', 'Votum Niepewności'}, {0,0,1,0}},
		{'Rafael, Leonardo Da Vinci, Michał Anioł, Jan Matejko - Który z tych artystów żył najdłużej?', {'Rafael', 'Jan Matejko', 'Michał Anioł', 'Leonardo Da Vinci'}, {0,0,1,0}},
		{'Któremu greckiemu lekarzowi przypisuje się przysięgę medyczną? Czyli kanon etyki lekarskie.', {'Hipokratesowi', 'Zeusowi', 'Edypowi', 'Heraklesowi'}, {1,0,0,0}},
		{'Z jakiego mięsa robi się kotlety schabowe?', {'Z cielęciny', 'Z wieprzowiny', 'Z dziczyzny', 'Z wołu'}, {0,1,0,0}},
		{'Które państwa połączył tunel pod masywem Mont Blanc?', {'Francje i Włochy', 'Niemcy i Włochy', 'Czechy i Włochy', 'Rosje i Włochy'}, {1,0,0,0}},
		{'Jak nazywał się chłop wielkopolski, który nie uzyskawszy zezwolenia władz Pruskich na budowę domu, przez 5 lat mieszkał w cyrkowym wozie?', {'Rosikoń','Dryzmała', 'Drzymała', 'Dryzdusz'}, {0,0,1,0}},
		---{'', {}, {}},
	},
};

return questions;