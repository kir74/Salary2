Процедура РасчитатьПремию(Регистратор) Экспорт
	
	НаборЗаписей = РегистрыРасчета.НачисленияСотрудников.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Регистратор);
	НаборЗаписей.Прочитать();
	
	ОтборПоИзмерениям = Новый Структура("Сотрудники", "НачисленияСотрудников.Сотрудники");
	
	ОтборПоРесурсам = Новый Массив(1);
	ОтборПоРесурсам[0] = "НачисленияСотрудников.Сумма";  
	
	ОтборПоРегистратору = Новый Структура("Регистратор", Регистратор);
		
	ТЗ_База = РегистрыРасчета.НачисленияСотрудников.ПолучитьБазу(ОтборПоРегистратору, 
																	ОтборПоРесурсам , 
																	ОтборПоИзмерениям);	
		
	ТЗ_ФактДней = РегистрыРасчета.НачисленияСотрудников.ПолучитьДанныеГрафика(ОтборПоРегистратору, 
										ВидПериодаРегистраРасчета.ФактическийПериодДействия);
				
	ТЗ_НормаДней = РегистрыРасчета.НачисленияСотрудников.ПолучитьДанныеГрафика(ОтборПоРегистратору, 
										ВидПериодаРегистраРасчета.ПериодРегистрации);
										
	ТЗ_БазаДней = РегистрыРасчета.НачисленияСотрудников.ПолучитьДанныеГрафика(ОтборПоРегистратору, 
										ВидПериодаРегистраРасчета.БазовыйПериод);

	Для Каждого Запись Из НаборЗаписей Цикл
		
		Индекс = НаборЗаписей.Индекс(Запись);
		База = ТЗ_База[Индекс].Сумма;
		СпособРасчета = Запись.ВидРасчета.Способ;
		ФактДней = ТЗ_ФактДней[Индекс].Признак;
		НормаДней = ТЗ_НормаДней[Индекс].Признак;
		БазаДней = ТЗ_БазаДней[Индекс].Признак;
		Параметр = Запись.Параметр;
		
		Если СпособРасчета = Перечисления.СпособыРасчета.Процентом Тогда
//			ТЗ_База = Запись.ПолучитьБазу(ОтборПоРесурсам, ОтборПоИзмерениям ); 	
//			База = ТЗ_База[0].Сумма; 
			Запись.Сумма = База * Запись.Параметр / 100;
		ИначеЕсли СпособРасчета = Перечисления.СпособыРасчета.ФиксированнаяСумма Тогда
			Запись.Сумма = Параметр;
		ИначеЕсли СпособРасчета  = Перечисления.СпособыРасчета.ПоДням Тогда 
			Запись.Сумма = ФактДней * Параметр;	
		ИначеЕсли СпособРасчета  = Перечисления.СпособыРасчета.ПропорциональноОтработанномуВремени Тогда
			Запись.Сумма = ФактДней/НормаДней*Параметр;
		КонецЕсли; 
					
		Если Запись.Сторно Тогда
			
			Запись.Сумма = - Запись.Сумма;
			
		КонецЕсли; 
							
					
	КонецЦикла;
	
	НаборЗаписей.Записать();
	
КонецПроцедуры