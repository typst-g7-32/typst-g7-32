#import "/src/export.typ": gost
#import "@preview/numberingx:0.0.1": formatter

#set enum(numbering: formatter("{lower-russian})"))
#show: gost.with(hide-title: true)

Автоматически нумерованные:  
+ Подготовка  
+ Анализ  
+ Выводы
+ Пункт с подпунктами
  + Проверка
  + Данные
  + Значения

Ручная нумерация:  
2. Каков первый шаг?  
5. Я запутался.  
+ Двигаемся дальше...  

Несколько строк:  
+ Этот элемент перечисления занимает несколько  
  строк, потому что следующая строка  
  имеет отступ.  

Вызов функции.  
#enum[Первый][Второй][Третий]