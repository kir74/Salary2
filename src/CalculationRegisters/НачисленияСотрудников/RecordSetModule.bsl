

Процедура ПередЗаписью(Отказ, Замещение, ТолькоЗапись, ЗаписьФактическогоПериодаДействия, ЗаписьПерерасчетов)
	Для Каждого Запись Из ЭтотОбъект Цикл
		Запись.ПериодДействияКонец = КонецДня(Запись.ПериодДействияКонец);
	КонецЦикла;
КонецПроцедуры
