#import "../../../../src/export.typ": gost

#show: gost.with(hide-title: true)

Чтобы оформить формулы в документе, можно использовать синтаксис typst-math. Примеры демонстрируют использование формул в шаблоне: 

Формула @example-formula-first показывает как применять сложные функции, формула  @example-formula-second демонстрирует как можно оформить матрицы, а формула @example-formula-third – использование типов и обозначений.


$ sum_(k=0)^n k = 1 + ... + n = (n(n+1)) / 2 $
<example-formula-first>


$ mat(1, 2, 3; 4, 5, 6; 7, 8, 9) * x = pi * psi(alef/x) $ 
<example-formula-second>

$ cal(A) := { x in RR | x "натуральное" } $
<example-formula-third>

#lorem(100)