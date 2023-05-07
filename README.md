# Tang_nano_9k_Miguel_A_Rodriguez_Jodar_mcleod_ideafix_MODULOS_ENTRENAMIENTO_VERILOG

La nomenclatura usada es la misma que el núcleo más avanzado hasta la fecha, el núcleo disponible de Next186, luego para esta microfpga seguiré dicha nomenclatura en las señales y sus restricciones a la hora de colocarlas en cada patilla.

Profesor Miguel Angel:

![Profesor Miguel Angel](https://github.com/AtlasFPGA/Tang_nano_9k_Miguel_A_Rodriguez_Jodar_mcleod_ideafix_MODULOS_ENTRENAMIENTO_VERILOG/blob/main/Fotos/MCLEOD_IDEAFIX.jpg)

Usamos la explicación del Profesor Miguel Angel, sacado de su primera comunicación en forofpga:
http://www.forofpga.es/viewtopic.php?t=60

Una de las características más comunes de las llamadas placas "entrenadoras" de FPGA (es decir, las placas que se venden precisamente para poder practicar con FPGAs por parte de Digilent, Terasic, y otros) es que disponen de cantidad de sistemas sencillos de usar, tanto de entrada de datos (botoneras, interruptores, conmutadores rotativos, etc) como de salida de datos (leds, displays de 7 segmentos, displays OLED, etc).

---

Funcionalidad de la entrenadora real creada por Miguel Angel:
![Funcionalidad de la entrenadora real creada por Miguel Angel](https://github.com/AtlasFPGA/Tang_nano_9k_Miguel_A_Rodriguez_Jodar_mcleod_ideafix_MODULOS_ENTRENAMIENTO_VERILOG/blob/main/Fotos/de2-115.jpg)

---


Estos añadidos sirven fundamentalmente para ayudar a depurar el hardware que se está diseñando. Depurar hardware tiende a ser más complejo que depurar software, y en muchos casos, hay que optar por algo equivalente a lo que en software es un mensaje de depuración, un pitido, o alguna otra cosa. Por ejemplo: estás depurando un módulo hardware de acceso a un teclado y quieres comprobar que efectivamente el sistema se da cuenta de que se ha pulsado una tecla. Pues bien, coges y enlazas un led a la señal que indica que una tecla se ha pulasdo. Así, cuando se pulsa una tecla, se enciende el led y se apaga cuando la sueltas. Cosas así...

En ZXUNO, ZXDOS y UnAmiga no tenemos nada de esto. La entrada de estos sistemas es el ratón y el teclado, cuyos módulos de control han de codificarse, y la salida principal es la pantalla.

Pues bien, para ayudar a todos aquellos que estais portando cores y necesitais algo que ayude a depurar errores ocultos, o para los que están empezando con esto del VHDL y el Verilog y necesitan una ayuda para "ver" como se comporta su diseño, he escrito un módulo que permite, principalmente, mostrar en pantalla una representación visual de lo que hay en estas placas entrenadoras.

Concretamente, las características del módulo "display", que es como lo he llamado, son las siguientes:
- Display de 12 dígitos hexadecimales independientes, agrupados visualmente en grupos de 4. La fuente de letras (8x8) es configurable por el usuario en tiempo de diseño.
- 8 interruptores ON/OFF controlados por las teclas F1 a F8 en el teclado
- 8 LEDs
- Generador de sincronismos y coordenadas de pixel X,Y para presentar gráficos en una pantalla de 640x480 a 60 Hz.
- Acceso a todas las teclas del teclado y su estado (pulsada/soltada) con lo que podemos usar todo el teclado para entrada de datos.
- Los elementos visuales del módulo pueden configurarse para que aparezcan a partir de cualquier posición vertical de pantalla (centrados horizontalmente). Se puede incluso usar una línea de pantalla superior a la máxima visible (479) para ocultar por completo el display y así tener toda la pantalla para generar gráficos.

En esta figura podeis ver qué pinta tiene el display. Antes de echar la foto, he pulsado F1, F5, F6 y F8 para encender algunos interruptores. La tira de leds que hay debajo de ellos muestra el valor fijo binario 10101010. El display hexadecimal muestra la secuencia de dígitos 0123456789AB usando la fuente por defecto (IBM 437).

---

La maguia del módulo display, en realidad es mucho mejor que las entrenadoras clásicas al poder disfrutar de ver como se manejan desde inicializaciones de roms a dibujar en pantalla VGA, si se quiere limitarse a accionar los interruptores generar números en los BCD se aprende los mismos contenidos que con cualquier entrenadora del mercado. ¡Insisto que se aprende más con estos ejercicios!
[Modulo display](https://github.com/AtlasFPGA/Tang_nano_9k_Miguel_A_Rodriguez_Jodar_mcleod_ideafix_MODULOS_ENTRENAMIENTO_VERILOG/blob/main/Fotos/display.jpg)

---

Para haceros una idea del tamaño de este display respecto de la anchura de la pantalla, tened en cuenta que el punto central del 0 ocupa 4 pixeles (un puntito hecho con 2x2 pixeles). Es decir, que cada carácter ocupa 16x16 pixeles, y dado que hay 12 caracteres más 2 espacios en blanco, la anchura de esa parte del display es de 112 píxeles, es decir, un 17,5% de la pantalla.

El módulo está escrito en Verilog, pero puede incluirse en proyectos tanto de Verilog como VHDL. He escrito un puñado de ejemplos... eso sí, en Verilog, porque no domino VHDL, que sirven para darle al usuario una idea un poco más concreta de cómo puede usar este módulo en sus diseños. Son en total 20 ejemplos, creo que decentemente comentados, y con una introducción sobre lo que hace y cómo usa el display. Hay un ejemplo aparte que no lo he escrito yo. No digo más... ;)

La estructura de directorios del ZIP adjunto es la siguiente:
- comun : contiene el módulo "display", y los ficheros .HEX de las fuentes de caracteres para el display, así como los ficheros PNG originales de esas fuentes (echadles un vistazo) y utilidades para hacer la conversión desde el PNG al HEX (se necesita ImageMagick instalado)
- ejemplos : los 20 ejemplos
- ejemplo99 : el ejemplo "extra"
- unamiga : proyecto completo para Quartus 18 que permite explorar cualquiera de los ejemplos
- zxdos : idem, pero para ZX-DOS usando el ISE Webpack 14.7
- zxuno : idem, pero para ZX-UNO v4.1 (o cualquiera compatible con él)
- zxuno_addon_vga18bits : idem, pero para el ZX-UNO con el addon VGA de 18 bits
En todos los casos, la salida de video es VGA. No RGB ni video compuesto.

Para elegir un ejemplo, sintetizarlo y verlo en acción, una vez que habeis cargado en Quartus o ISE Webpack el proyecto que corresponde a vuestra placa, abrid el fichero tld_modulos_entrenamiento_nombredevuestraplaca.v y allí vereis un montón de "includes" con comentarios. Quitadle los comentarios al que vais a usar y dejádselo a los demás. Llevad el propio fichero de ejemplo al editor para leer la introducción y saber qué hace, y cómo podemos manejarlo.

Huelga decir que se necesita el programador JTAG para trabajar con esto, enviando el diseño listo a la FPGA (USB Blaster para UnAmiga, Xilinx JTAG o algo euivalente para ZXUNO y ZXDOS). Es posible, para ZXUNO y ZXDOS, generar el fichero .ZX1 / .ZX2 a partir del BIT y grabarlo a la flash de la FPGA desde la BIOS. De todas formas, si estais pensando ligeramente en serio trastear con la FPGA, necesitareis un cable JTAG sí o sí.

OJO en Quartus, porque este entorno tiene la costumbre de cuando menos te lo esperas, añadir el fichero con el ejemplo actual al proyecto como si fuera uno más. No debe permitirse eso, sino que los ejemplos son siempre incluidos desde el tld, nunca van aparte.

Cada ejemplo asume que el TLD proporciona un reloj de 25 MHz. En cada proyecto se ha incluido un generador de reloj adecuado a cada placa.

Luego contaré más cosas, pero de momento podeis bichear con los ejemplos que os he pasado. Aunque esto no es un curso de HDL o de Verilog en particular, muchos de vosotros, sobre todo si teneis algo de bagaje en programación en C, Java u otro lenguaje con sintaxis similar, se sorprenderá al pillar la idea de todo el código, o al menos parte de él.
