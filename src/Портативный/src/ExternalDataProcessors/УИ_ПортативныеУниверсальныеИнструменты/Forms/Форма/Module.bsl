﻿// Хранилище глобальных переменных.
//
// ПараметрыПриложения - Соответствие - хранилище переменных, где:
//   * Ключ - Строка - имя переменной в формате "ИмяБиблиотеки.ИмяПеременной";
//   * Значение - Произвольный - значение переменной.
//
// Инициализация (на примере СообщенияДляЖурналаРегистрации):
//   ИмяПараметра = "СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации";
//   Если ПараметрыПриложения[ИмяПараметра] = Неопределено Тогда
//     ПараметрыПриложения.Вставить(ИмяПараметра, Новый СписокЗначений);
//   КонецЕсли;
//  
// Использование (на примере СообщенияДляЖурналаРегистрации):
//   ПараметрыПриложения["СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации"].Добавить(...);
//   ПараметрыПриложения["СтандартныеПодсистемы.СообщенияДляЖурналаРегистрации"] = ...;
&НаКлиенте
Перем УИ_ПараметрыПриложения Экспорт;
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбработкаОбъект=РеквизитФормыВЗначение("Объект");

	Файл=Новый Файл(ОбработкаОбъект.ИспользуемоеИмяФайла);
	КаталогИнструментов=Файл.Путь;

	СоздатьКомандыОткрытияИнструментовНаФорме();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ПодключитьВнешниеМодули();
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	УИ_ОбщегоНазначенияКлиент.ПриЗавершенииРаботыСистемы();
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОткрытьКомандуИнструмента(Команда)
	ОписанияМодулей=ОписаниеМодулейИнструментовДляПодключения();
	ОписаниеМодуля=ОписанияМодулей[Команда.Имя];

	Если ОписаниеМодуля.Вид = "Отчет" Тогда
		ОткрытьФорму("ВнешнийОтчет." + Команда.Имя + ".Форма", , ЭтаФорма);
	Иначе
		ОткрытьФорму("ВнешняяОбработка." + Команда.Имя + ".Форма", , ЭтаФорма);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура СоздатьКомандыОткрытияИнструментовНаФорме()
	ОписаниеИнструментов=ОписаниеМодулейИнструментовДляПодключения();

	Четный=Ложь;
	Для Каждого КлючЗначение Из ОписаниеИнструментов Цикл
		Описание=КлючЗначение.Значение;
		Если Описание.Тип <> "Инструмент" Тогда
			Продолжить;
		КонецЕсли;
		
		//1. Добавляем команду на форму
		Команда=Команды.Добавить(Описание.Имя);
		Команда.Действие="Подключаемый_ОткрытьКомандуИнструмента";
		Команда.Заголовок=Описание.Синоним;
		Команда.Отображение=ОтображениеКнопки.КартинкаИТекст;

		Если Четный Тогда
			Родитель=Элементы.ГруппаКомандыИнструментовПраво;
		Иначе
			Родитель=Элементы.ГруппаКомандыИнструментовЛево;
		КонецЕсли;

		Элемент=Элементы.Добавить(Описание.Имя, Тип("КнопкаФормы"), Родитель);
		Элемент.ИмяКоманды=Команда.Имя;
		Элемент.вид=ВидКнопкиФормы.Гиперссылка;

		Четный=Не Четный;
	КонецЦикла;
КонецПроцедуры
&НаКлиентеНаСервереБезКонтекста
Функция НовыйОписаниеМодуля() Экспорт
	Описание=Новый Структура;
	Описание.Вставить("Имя", "");
	Описание.Вставить("Синоним", "");
	Описание.Вставить("ИмяФайла", "");
	Описание.Вставить("Тип", "Инструмент");
	Описание.Вставить("Вид", "Обработка");
	Описание.Вставить("Команды", Неопределено);

	Возврат Описание;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ОписаниеМодулейИнструментовДляПодключения()
	Описания=Новый Структура;
	
	// МЕТОД ГЕНЕРИРУЕТСЯ ПРИ СБОРКЕ
	
//	ОписаниеИнструмента=НовыйОписаниеМодуля();
//	ОписаниеИнструмента.Имя="УИ_РедакторСКД";
//	Описания.Вставить(ОписаниеИнструмента.Имя,ОписаниеИнструмента);
//	
//	ОписаниеИнструмента=НовыйОписаниеМодуля();
//	ОписаниеИнструмента.Имя="УИ_КонсольОтчетов";
//	ОписаниеИнструмента.Вид="Отчет";
//	Описания.Вставить(ОписаниеИнструмента.Имя,ОписаниеИнструмента);
//	
//	ОписаниеИнструмента=НовыйОписаниеМодуля();
//	ОписаниеИнструмента.Имя="УИ_БуферОбменаКлиент";
//	ОписаниеИнструмента.Тип="ОбщийМодуль";
//	Описания.Вставить(ОписаниеИнструмента.Имя,ОписаниеИнструмента);
//	
//	ОписаниеИнструмента=НовыйОписаниеМодуля();
//	ОписаниеИнструмента.Имя="УИ_ОбщегоНазначенияКлиент";
//	ОписаниеИнструмента.Тип="ОбщийМодуль";
//	Описания.Вставить(ОписаниеИнструмента.Имя,ОписаниеИнструмента);
//	ОписаниеИнструмента=НовыйОписаниеМодуля();
//	
//	ОписаниеИнструмента.Имя="УИ_ОбщегоНазначенияКлиентСервер";
//	ОписаниеИнструмента.Тип="ОбщийМодуль";
//	Описания.Вставить(ОписаниеИнструмента.Имя,ОписаниеИнструмента);
//	
//	ОписаниеИнструмента=НовыйОписаниеМодуля();
//	ОписаниеИнструмента.Имя="УИ_РаботаСФормами";
//	ОписаниеИнструмента.Тип="ОбщийМодуль";
//	Описания.Вставить(ОписаниеИнструмента.Имя,ОписаниеИнструмента);

	Возврат Описания;
КонецФункции

&НаКлиенте
Функция ИмяФайлаМодуля(ОписаниеМодуля)
	Если ОписаниеМодуля.Тип = "ОбщийМодуль" Тогда
		КаталогМодуля="ОбщиеМодули";
	ИначеЕсли ОписаниеМодуля.Тип="ОбщаяКартинка" Тогда
		Возврат КаталогИнструментов+ПолучитьРазделительПути()+"Картинки"+ПолучитьРазделительПути()+ОписаниеМодуля.ИмяФайла;
	Иначе
		КаталогМодуля="Инструменты";
	КонецЕсли;

	Если ОписаниеМодуля.Вид = "Отчет" Тогда
		Расширение="erf";
	Иначе
		Расширение="epf";
	КонецЕсли;

	Возврат КаталогИнструментов + ПолучитьРазделительПути() + КаталогМодуля + ПолучитьРазделительПути()
		+ ОписаниеМодуля.Имя + "." + Расширение;
КонецФункции

&НаКлиенте
Процедура ПодключитьВнешниеМодули()
	Описание=ОписаниеМодулейИнструментовДляПодключения();

	ПомещаемыеФайлы=Новый Массив;

	Для Каждого КлючЗначение Из Описание Цикл
		ТекОписаниеИнструмента=КлючЗначение.Значение;
		ПомещаемыеФайлы.Добавить(Новый ОписаниеПередаваемогоФайла(ИмяФайлаМодуля(ТекОписаниеИнструмента)));
	КонецЦикла;

	НачатьПомещениеФайлов(Новый ОписаниеОповещения("ПодключитьВнешниеМодулиЗавершение", ЭтаФорма,
		Новый Структура("ОписаниеИнструментов", Описание)), ПомещаемыеФайлы, , Ложь, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ПодключитьВнешниеМодулиЗавершение(ПомещенныеФайлы, ДополнительныеПараметры) Экспорт
	Если ПомещенныеФайлы = Неопределено Тогда
		Возврат;
	КонецЕсли;

	УИ_БиблиотекаКартинок=Новый Структура;

	МодулиДляПодключенияНаСервере=Новый Массив;

	Для Каждого ПомещенныйФайл Из ПомещенныеФайлы Цикл
		Если УИ_ОбщегоНазначенияКлиентСервер.ВерсияПлатформыНеМладше("8.3.13") Тогда
			ИмяФайла = ПомещенныйФайл.ПолноеИмя;
		Иначе
			ИмяФайла = ПомещенныйФайл.Имя;
		КонецЕсли;
		
		Файл=Новый Файл(ИмяФайла);
		Если НРег(Файл.Расширение) = ".erf" Тогда
			МодулиДляПодключенияНаСервере.Добавить(Новый Структура("ЭтоОтчет, Адрес", Истина, ПомещенныйФайл.Хранение));
		ИначеЕсли НРег(Файл.Расширение) = ".epf" Тогда
			МодулиДляПодключенияНаСервере.Добавить(Новый Структура("ЭтоОтчет, Адрес", Ложь, ПомещенныйФайл.Хранение));
		Иначе
			УИ_БиблиотекаКартинок.Вставить(Файл.ИмяБезРасширения, Новый Картинка(Файл.ПолноеИмя));
			Продолжить;
		КонецЕсли;
	КонецЦикла;

	ПодключитьВнешниеМодулиНаСервере(МодулиДляПодключенияНаСервере);

	АдресЛокальнойБиблиотекиКартинок=ПоместитьВоВременноеХранилище(УИ_БиблиотекаКартинок, УникальныйИдентификатор);
	ЗаписатьАдресЛокальнойБиблиотекиКартинокВХранилищеНастроек(АдресЛокальнойБиблиотекиКартинок);

	УИ_ОбщегоНазначенияКлиент.ПриНачалеРаботыСистемы();

КонецПроцедуры

&НаСервере
Процедура ПодключитьВнешниеМодулиНаСервере(МодулиДляПодключенияНаСервере)
	Для Каждого ВнешнийМодуль ИЗ МодулиДляПодключенияНаСервере Цикл
		ПодключитьВнешнююОбработку(ВнешнийМодуль.Адрес, ВнешнийМодуль.ЭтоОтчет);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция ПодключитьВнешнююОбработку(АдресХранилища, ЭтоОтчет)

	ОписаниеЗащитыОтОпасныхДействий =Новый ОписаниеЗащитыОтОпасныхДействий;
	ОписаниеЗащитыОтОпасныхДействий.ПредупреждатьОбОпасныхДействиях=Ложь;
	Если ЭтоОтчет Тогда
		Возврат ВнешниеОтчеты.Подключить(АдресХранилища, , Ложь, ОписаниеЗащитыОтОпасныхДействий);
	Иначе
		Возврат ВнешниеОбработки.Подключить(АдресХранилища, , Ложь, ОписаниеЗащитыОтОпасныхДействий);
	КонецЕсли;
КонецФункции

&НаСервере
Процедура ЗаписатьАдресЛокальнойБиблиотекиКартинокВХранилищеНастроек(Адрес)
	УИ_ОбщегоНазначения.ХранилищеНастроекДанныхФормСохранить(
		УИ_ОбщегоНазначенияКлиентСервер.КлючОбъектаВХранилищеНастроек(), "АдресЛокальнойБиблиотекиКартинок", Адрес, ,
		ИмяПользователя());
КонецПроцедуры

УИ_ПараметрыПриложения = Новый Соответствие;
