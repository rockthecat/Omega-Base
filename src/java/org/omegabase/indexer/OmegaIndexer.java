package org.omegabase.indexer;
import java.io.*;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CodingErrorAction;
import org.apache.log4j.*;
//import com.itextpdf.text.pdf.*;
//import com.itextpdf.text.pdf.parser.*;
import javax.xml.parsers.*;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.*;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.util.zip.*;
import org.apache.pdfbox.pdmodel.*;
import org.apache.pdfbox.util.*;

/*
LICENÃA PÃBLICA GERAL GNU
 VersÃ£o 2, junho de 1991

This is an unofficial translation of the GNU General Public License
into Brazilian Portuguese. It was not published by the Free Software
Foundation, and does not legally state the distribution terms for
software that uses the GNU GPL -- only the original English text of
the GNU GPL does that. However, we hope that this translation will
help Brazilian Portuguese speakers understand the GNU GPL better.

Esta Ã© uma traduÃ§Ã£o nÃ£o-oficial da LicenÃ§a PÃºblica Geral GNU ("GPL
GNU") para o portuguÃªs do Brasil. Ela nÃ£o foi publicada pela Free
Software Foundation, e legalmente nÃ£o afirma os termos de distribuiÃ§Ã£o
de software que utiliza a GPL GNU -- apenas o texto original da GPL
GNU, em inglÃªs, faz isso. Contudo, esperamos que esta traduÃ§Ã£o ajude
aos que utilizam o portuguÃªs do Brasil a entender melhor a GPL GNU.

Copyright (C) 1989, 1991 Free Software Foundation, Inc. 675 Mass Ave,
  Cambridge, MA 02139, USA

A qualquer pessoa Ã© permitido copiar e distribuir cÃ³pias desse
documento de licenÃ§a, desde que sem qualquer alteraÃ§Ã£o.

        IntroduÃ§Ã£o

As licenÃ§as de muitos software sÃ£o desenvolvidas para restringir sua
liberdade de compartilhÃ¡-lo e mudÃ¡-lo. ContrÃ¡ria a isso, a LicenÃ§a
PÃºblica Geral GNU pretende garantir sua liberdade de compartilhar e
alterar software livres -- garantindo que o software serÃ¡ livre e
gratuito para os seus usuÃ¡rios. Esta LicenÃ§a PÃºblica Geral aplica-se Ã 
maioria dos software da Free Software Foundation e a qualquer outro
programa cujo autor decida aplicÃ¡-la. (Alguns outros software da FSF
sÃ£o cobertos pela LicenÃ§a PÃºblica Geral de Bibliotecas, no entanto.)
VocÃª pode aplicÃ¡-la tambÃ©m aos seus programas.

Quando nos referimos a software livre, estamos nos referindo a
liberdade e nÃ£o a preÃ§o. Nossa LicenÃ§a PÃºblica Geral foi desenvolvida
para garantir que vocÃª tenha a liberdade de distribuir cÃ³pias de
software livre (e cobrar por isso, se quiser); que vocÃª receba o
cÃ³digo-fonte ou tenha acesso a ele, se quiser; que vocÃª possa mudar o
software ou utilizar partes dele em novos programas livres e
gratuitos; e que vocÃª saiba que pode fazer tudo isso.

Para proteger seus direitos, precisamos fazer restriÃ§Ãµes que impeÃ§am
a qualquer um negar estes direitos ou solicitar que vocÃª deles
abdique. Estas restriÃ§Ãµes traduzem-se em certas responsabilidades para
vocÃª, se vocÃª for distribuir cÃ³pias do software ou modificÃ¡-lo.

Por exemplo, se vocÃª distribuir cÃ³pias de um programa, gratuitamente
ou por alguma quantia, vocÃª tem que fornecer aos recebedores todos os
direitos que vocÃª possui. VocÃª tem que garantir que eles tambÃ©m
recebam ou possam obter o cÃ³digo-fonte. E vocÃª tem que mostrar-lhes
estes termos para que eles possam conhecer seus direitos.

NÃ³s protegemos seus direitos em dois passos: (1) com copyright do
software e (2) com a oferta desta licenÃ§a, que lhe dÃ¡ permissÃ£o legal
para copiar, distribuir e/ou modificar o software.

AlÃ©m disso, tanto para a proteÃ§Ã£o do autor quanto a nossa,
gostarÃ­amos de certificar-nos que todos entendam que nÃ£o hÃ¡ qualquer
garantia nestes software livres. Se o software Ã© modificado por alguÃ©m
mais e passado adiante, queremos que seus recebedores saibam que o que
eles obtiveram nÃ£o Ã© original, de forma que qualquer problema
introduzido por terceiros nÃ£o interfira na reputaÃ§Ã£o do autor
original.

Finalmente, qualquer programa Ã© ameaÃ§ado constantemente por patentes
de software. Queremos evitar o perigo de que distribuidores de
software livre obtenham patentes individuais, o que tem o efeito de
tornar o programa proprietÃ¡rio. Para prevenir isso, deixamos claro que
qualquer patente tem que ser licenciada para uso livre e gratuito por
qualquer pessoa, ou entÃ£o que nem necessite ser licenciada.

Os termos e condiÃ§Ãµes precisas para cÃ³pia, distribuiÃ§Ã£o e
modificaÃ§Ã£o se encontram abaixo:

LICENÃA PÃBLICA GERAL GNU
TERMOS E CONDIÃÃES PARA CÃPIA, DISTRIBUIÃÃO E MODIFICAÃÃO

0. Esta licenÃ§a se aplica a qualquer programa ou outro trabalho que
contenha um aviso colocado pelo detentor dos direitos autorais
informando que aquele pode ser distribuÃ­do sob as condiÃ§Ãµes desta
LicenÃ§a PÃºblica Geral. O "Programa" abaixo refere-se a qualquer
programa ou trabalho, e "trabalho baseado no Programa" significa tanto
o Programa em si como quaisquer trabalhos derivados, de acordo com a
lei de direitos autorais: isto quer dizer um trabalho que contenha o
Programa ou parte dele, tanto originalmente ou com modificaÃ§Ãµes, e/ou
traduÃ§Ã£o para outros idiomas. (Doravante o processo de traduÃ§Ã£o estÃ¡
incluÃ­do sem limites no termo "modificaÃ§Ã£o".) Cada licenciado Ã©
mencionado como "vocÃª".

Atividades outras que a cÃ³pia, a distribuiÃ§Ã£o e modificaÃ§Ã£o nÃ£o estÃ£o
cobertas por esta LicenÃ§a; elas estÃ£o fora de seu escopo.  O ato de
executar o Programa nÃ£o Ã© restringido e o resultado do Programa Ã©
coberto apenas se seu conteÃºdo contenha trabalhos baseados no Programa
(independentemente de terem sido gerados pela execuÃ§Ã£o do
Programa). Se isso Ã© verdadeiro depende do que o programa faz.

1. VocÃª pode copiar e distribuir cÃ³pias fiÃ©is do cÃ³digo-fonte do
Programa da mesma forma que vocÃª o recebeu, usando qualquer meio,
deste que vocÃª conspÃ­cua e apropriadamente publique em cada cÃ³pia um
aviso de direitos autorais e uma declaraÃ§Ã£o de inexistÃªncia de
garantias; mantenha intactas todos os avisos que se referem a esta
LicenÃ§a e Ã  ausÃªncia total de garantias; e forneÃ§a a outros
recebedores do Programa uma cÃ³pia desta LicenÃ§a, junto com o Programa.

VocÃª pode cobrar pelo ato fÃ­sico de transferir uma cÃ³pia e pode,
opcionalmente, oferecer garantia em troca de pagamento.

2. VocÃª pode modificar sua cÃ³pia ou cÃ³pias do Programa, ou qualquer
parte dele, assim gerando um trabalho baseado no Programa, e copiar e
distribuir essas modificaÃ§Ãµes ou trabalhos sob os termos da seÃ§Ã£o 1
acima, desde que vocÃª tambÃ©m se enquadre em todas estas condiÃ§Ãµes:

a) VocÃª tem que fazer com que os arquivos modificados levem avisos
proeminentes afirmando que vocÃª alterou os arquivos, incluindo a
data de qualquer alteraÃ§Ã£o.

b) VocÃª tem que fazer com que quaisquer trabalhos que vocÃª
distribua ou publique, e que integralmente ou em partes contenham
ou sejam derivados do Programa ou de suas partes, sejam
licenciados, integralmente e sem custo algum para quaisquer
terceiros, sob os termos desta LicenÃ§a.

c) Se qualquer programa modificado normalmente lÃª comandos
interativamente quando executados, vocÃª tem que fazer com que,
quando iniciado tal uso interativo da forma mais simples, seja
impresso ou mostrado um anÃºncio de que nÃ£o hÃ¡ qualquer garantia
(ou entÃ£o que vocÃª fornece a garantia) e que os usuÃ¡rios podem
redistribuir o programa sob estas condiÃ§Ãµes, ainda informando os
usuÃ¡rios como consultar uma cÃ³pia desta LicenÃ§a. (ExceÃ§Ã£o: se o
Programa em si Ã© interativo mas normalmente nÃ£o imprime estes
tipos de anÃºncios, seu trabalho baseado no Programa nÃ£o precisa
imprimir um anÃºncio.)

Estas exigÃªncias aplicam-se ao trabalho modificado como um todo. Se
seÃ§Ãµes identificÃ¡veis de tal trabalho nÃ£o sÃ£o derivadas do Programa, e
podem ser razoavelmente consideradas trabalhos independentes e
separados por si sÃ³, entÃ£o esta LicenÃ§a, e seus termos, nÃ£o se aplicam
a estas seÃ§Ãµes quando vocÃª distribui-las como trabalhos em
separado. Mas quando vocÃª distribuir as mesmas seÃ§Ãµes como parte de um
todo que Ã© trabalho baseado no Programa, a distribuiÃ§Ã£o como um todo
tem que se enquadrar nos termos desta LicenÃ§a, cujas permissÃµes para
outros licenciados se estendem ao todo, portanto tambÃ©m para cada e
toda parte independente de quem a escreveu.

Desta forma, esta seÃ§Ã£o nÃ£o tem a intenÃ§Ã£o de reclamar direitos os
contestar seus direitos sobre o trabalho escrito completamente por
vocÃª; ao invÃ©s disso, a intenÃ§Ã£o Ã© a de exercitar o direito de
controlar a distribuiÃ§Ã£o de trabalhos, derivados ou coletivos,
baseados no Programa.

Adicionalmente, a mera adiÃ§Ã£o ao Programa de outro trabalho nÃ£o
baseado no Programa (ou de trabalho baseado no Programa) em um volume
de armazenamento ou meio de distribuiÃ§Ã£o nÃ£o faz o outro trabalho
parte do escopo desta LicenÃ§a.

3. VocÃª pode copiar e distribuir o Programa (ou trabalho baseado
nele, conforme descrito na SeÃ§Ã£o 2) em cÃ³digo-objeto ou em forma
executÃ¡vel sob os termos das SeÃ§Ãµes 1 e 2 acima, desde que vocÃª
faÃ§a um dos seguintes:

a) O acompanhe com o cÃ³digo-fonte completo e em forma acessÃ­vel
por mÃ¡quinas, que tem que ser distribuÃ­do sob os termos das SeÃ§Ãµes
1 e 2 acima e em meio normalmente utilizado para o intercÃ¢mbio de
software; ou,

b) O acompanhe com uma oferta escrita, vÃ¡lida por pelo menos trÃªs
anos, de fornecer a qualquer um, com um custo nÃ£o superior ao
custo de distribuiÃ§Ã£o fÃ­sica do material, uma cÃ³pia do
cÃ³digo-fonte completo e em forma acessÃ­vel por mÃ¡quinas, que tem
que ser distribuÃ­do sob os termos das SeÃ§Ãµes 1 e 2 acima e em meio
normalmente utilizado para o intercÃ¢mbio de software; ou,

c) O acompanhe com a informaÃ§Ã£o que vocÃª recebeu em relaÃ§Ã£o Ã 
oferta de distribuiÃ§Ã£o do cÃ³digo-fonte correspondente. (Esta
alternativa Ã© permitida somente em distribuiÃ§Ã£o nÃ£o comerciais, e
apenas se vocÃª recebeu o programa em forma de cÃ³digo-objeto ou
executÃ¡vel, com oferta de acordo com a SubseÃ§Ã£o b acima.)

O cÃ³digo-fonte de um trabalho corresponde Ã  forma de trabalho
preferida para se fazer modificaÃ§Ãµes. Para um trabalho em forma
executÃ¡vel, o cÃ³digo-fonte completo significa todo o cÃ³digo-fonte de
todos os mÃ³dulos que ele contÃ©m, mais quaisquer arquivos de definiÃ§Ã£o
de "interface", mais os "scripts" utilizados para se controlar a
compilaÃ§Ã£o e a instalaÃ§Ã£o do executÃ¡vel. Contudo, como exceÃ§Ã£o
especial, o cÃ³digo-fonte distribuÃ­do nÃ£o precisa incluir qualquer
componente normalmente distribuÃ­do (tanto em forma original quanto
binÃ¡ria) com os maiores componentes (o compilador, o "kernel" etc.) do
sistema operacional sob o qual o executÃ¡vel funciona, a menos que o
componente em si acompanhe o executÃ¡vel.

Se a distribuiÃ§Ã£o do executÃ¡vel ou cÃ³digo-objeto Ã© feita atravÃ©s da
oferta de acesso a cÃ³pias de algum lugar, entÃ£o ofertar o acesso
equivalente a cÃ³pia, do mesmo lugar, do cÃ³digo-fonte equivale Ã 
distribuiÃ§Ã£o do cÃ³digo-fonte, mesmo que terceiros nÃ£o sejam compelidos
a copiar o cÃ³digo-fonte com o cÃ³digo-objeto.

4. VocÃª nÃ£o pode copiar, modificar, sub-licenciar ou distribuir o
Programa, exceto de acordo com as condiÃ§Ãµes expressas nesta
LicenÃ§a. Qualquer outra tentativa de cÃ³pia, modificaÃ§Ã£o,
sub-licenciamento ou distribuiÃ§Ã£o do Programa nÃ£o Ã© valida, e
cancelarÃ¡ automaticamente os direitos que lhe foram fornecidos por
esta LicenÃ§a. No entanto, terceiros que de vocÃª receberam cÃ³pias ou
direitos, fornecidos sob os termos desta LicenÃ§a, nÃ£o terÃ£o suas
licenÃ§as terminadas, desde que permaneÃ§am em total concordÃ¢ncia com
ela.

5. VocÃª nÃ£o Ã© obrigado a aceitar esta LicenÃ§a jÃ¡ que nÃ£o a
assinou. No entanto, nada mais o darÃ¡ permissÃ£o para modificar ou
distribuir o Programa ou trabalhos derivados deste. Estas aÃ§Ãµes sÃ£o
proibidas por lei, caso vocÃª nÃ£o aceite esta LicenÃ§a. Desta forma, ao
modificar ou distribuir o Programa (ou qualquer trabalho derivado do
Programa), vocÃª estarÃ¡ indicando sua total aceitaÃ§Ã£o desta LicenÃ§a
para fazÃª-los, e todos os seus termos e condiÃ§Ãµes para copiar,
distribuir ou modificar o Programa, ou trabalhos baseados nele.

6. Cada vez que vocÃª redistribuir o Programa (ou qualquer trabalho
baseado nele), os recebedores adquirirÃ£o automaticamente do
licenciador original uma licenÃ§a para copiar, distribuir ou modificar
o Programa, sujeitos a estes termos e condiÃ§Ãµes. VocÃª nÃ£o poderÃ¡ impor
aos recebedores qualquer outra restriÃ§Ã£o ao exercÃ­cio dos direitos
entÃ£o adquiridos. VocÃª nÃ£o Ã© responsÃ¡vel em garantir a concordÃ¢ncia de
terceiros a esta LicenÃ§a.

7. Se, em conseqÃ¼Ãªncia de decisÃµes judiciais ou alegaÃ§Ãµes de
infringimento de patentes ou quaisquer outras razÃµes (nÃ£o limitadas a
assuntos relacionados a patentes), condiÃ§Ãµes forem impostas a vocÃª
(por ordem judicial, acordos ou outras formas) e que contradigam as
condiÃ§Ãµes desta LicenÃ§a, elas nÃ£o o livram das condiÃ§Ãµes desta
LicenÃ§a. Se vocÃª nÃ£o puder distribuir de forma a satisfazer
simultaneamente suas obrigaÃ§Ãµes para com esta LicenÃ§a e para com as
outras obrigaÃ§Ãµes pertinentes, entÃ£o como conseqÃ¼Ãªncia vocÃª nÃ£o poderÃ¡
distribuir o Programa. Por exemplo, se uma licenÃ§a de patente nÃ£o
permitirÃ¡ a redistribuiÃ§Ã£o, livre de "royalties", do Programa, por
todos aqueles que receberem cÃ³pias direta ou indiretamente de vocÃª,
entÃ£o a Ãºnica forma de vocÃª satisfazer a ela e a esta LicenÃ§a seria a
de desistir completamente de distribuir o Programa.

Se qualquer parte desta seÃ§Ã£o for considerada invÃ¡lida ou nÃ£o
aplicÃ¡vel em qualquer circunstÃ¢ncia particular, o restante da seÃ§Ã£o se
aplica, e a seÃ§Ã£o como um todo se aplica em outras circunstÃ¢ncias.

O propÃ³sito desta seÃ§Ã£o nÃ£o Ã© o de induzi-lo a infringir quaisquer
patentes ou reivindicaÃ§Ã£o de direitos de propriedade outros, ou a
contestar a validade de quaisquer dessas reivindicaÃ§Ãµes; esta seÃ§Ã£o
tem como Ãºnico propÃ³sito proteger a integridade dos sistemas de
distribuiÃ§Ã£o de software livres, o que Ã© implementado pela prÃ¡tica de
licenÃ§as pÃºblicas. VÃ¡rias pessoas tÃªm contribuÃ­do generosamente e em
grande escala para os software distribuÃ­dos usando este sistema, na
certeza de que sua aplicaÃ§Ã£o Ã© feita de forma consistente; fica a
critÃ©rio do autor/doador decidir se ele ou ela estÃ¡ disposto a
distribuir software utilizando outro sistema, e um licenciado nÃ£o pode
impor qualquer escolha.

Esta seÃ§Ã£o destina-se a tornar bastante claro o que se acredita ser
conseqÃ¼Ãªncia do restante desta LicenÃ§a.

8. Se a distribuiÃ§Ã£o e/ou uso do Programa sÃ£o restringidos em certos
paÃ­ses por patentes ou direitos autorais, o detentor dos direitos
autorais original, e que colocou o Programa sob esta LicenÃ§a, pode
incluir uma limitaÃ§Ã£o geogrÃ¡fica de distribuiÃ§Ã£o, excluindo aqueles
paÃ­ses de forma a tornar a distribuiÃ§Ã£o permitida apenas naqueles ou
entre aqueles paÃ­ses entÃ£o nÃ£o excluÃ­dos. Nestes casos, esta LicenÃ§a
incorpora a limitaÃ§Ã£o como se a mesma constasse escrita nesta LicenÃ§a.

9. A Free Software Foundation pode publicar versÃµes revisadas e/ou
novas da LicenÃ§a PÃºblica Geral de tempos em tempos. Estas novas
versÃµes serÃ£o similares em espÃ­rito Ã  versÃ£o atual, mas podem diferir
em detalhes que resolvem novos problemas ou situaÃ§Ãµes.

A cada versÃ£o Ã© dada um nÃºmero distinto. Se o Programa especifica um
nÃºmero de versÃ£o especÃ­fico desta LicenÃ§a que se aplica a ele e a
"qualquer nova versÃ£o", vocÃª tem a opÃ§Ã£o de aceitar os termos e
condiÃ§Ãµes daquela versÃ£o ou de qualquer outra versÃ£o publicada pela
Free Software Foundation. Se o programa nÃ£o especifica um nÃºmero de
versÃ£o desta LicenÃ§a, vocÃª pode escolher qualquer versÃ£o jÃ¡ publicada
pela Free Software Foundation.

10. Se vocÃª pretende incorporar partes do Programa em outros
programas livres cujas condiÃ§Ãµes de distribuiÃ§Ã£o sÃ£o diferentes,
escreva ao autor e solicite permissÃ£o. Para o software que a Free
Software Foundation detÃ©m direitos autorais, escreva Ã  Free Software
Foundation; Ã s vezes nÃ³s permitimos exceÃ§Ãµes a este caso. Nossa
decisÃ£o serÃ¡ guiada pelos dois objetivos de preservar a condiÃ§Ã£o de
liberdade de todas as derivaÃ§Ãµes do nosso software livre, e de
promover o compartilhamento e reutilizaÃ§Ã£o de software em aspectos
gerais.

  AUSÃNCIA DE GARANTIAS

11. UMA VEZ QUE O PROGRAMA Ã LICENCIADO SEM ÃNUS, NÃO HÃ QUALQUER
GARANTIA PARA O PROGRAMA, NA EXTENSÃO PERMITIDA PELAS LEIS
APLICÃVEIS. EXCETO QUANDO EXPRESSADO DE FORMA ESCRITA, OS DETENTORES
DOS DIREITOS AUTORAIS E/OU TERCEIROS DISPONIBILIZAM O PROGRAMA "NO
ESTADO", SEM QUALQUER TIPO DE GARANTIAS, EXPRESSAS OU IMPLÃCITAS,
INCLUINDO, MAS NÃO LIMITADO A, AS GARANTIAS IMPLÃCITAS DE
COMERCIALIZAÃÃO E AS DE ADEQUAÃÃO A QUALQUER PROPÃSITO. O RISCO TOTAL
COM A QUALIDADE E DESEMPENHO DO PROGRAMA Ã SEU. SE O PROGRAMA SE
MOSTRAR DEFEITUOSO, VOCÃ ASSUME OS CUSTOS DE TODAS AS MANUTENÃÃES,
REPAROS E CORREÃÃES.

12. EM NENHUMA OCASIÃO, A MENOS QUE EXIGIDO PELAS LEIS APLICÃVEIS OU
ACORDO ESCRITO, OS DETENTORES DOS DIREITOS AUTORAIS, OU QUALQUER OUTRA
PARTE QUE POSSA MODIFICAR E/OU REDISTRIBUIR O PROGRAMA CONFORME
PERMITIDO ACIMA, SERÃO RESPONSABILIZADOS POR VOCÃ POR DANOS, INCLUINDO
QUALQUER DANO EM GERAL, ESPECIAL, ACIDENTAL OU CONSEQÃENTE,
RESULTANTES DO USO OU INCAPACIDADE DE USO DO PROGRAMA (INCLUINDO, MAS
NÃO LIMITADO A, A PERDA DE DADOS OU DADOS TORNADOS INCORRETOS, OU
PERDAS SOFRIDAS POR VOCÃ OU POR OUTRAS PARTES, OU FALHAS DO PROGRAMA
AO OPERAR COM QUALQUER OUTRO PROGRAMA), MESMO QUE TAL DETENTOR OU
PARTE TENHAM SIDO AVISADOS DA POSSIBILIDADE DE TAIS DANOS.

FIM DOS TERMOS E CONDIÃÃES

Como Aplicar Estes Termos aos Seus Novos Programas

Se vocÃª desenvolver um novo programa, e quer que ele seja utilizado
amplamente pelo pÃºblico, a melhor forma de alcanÃ§ar este objetivo Ã©
tornÃ¡-lo software livre que qualquer um pode redistribuir e alterar,
sob estes termos.

Para isso, anexe os seguintes avisos ao programa. Ã mais seguro
anexÃ¡-los logo no inÃ­cio de cada arquivo-fonte para reforÃ§arem mais
efetivamente a inexistÃªncia de garantias; e cada arquivo deve possuir
pelo menos a linha de "copyright" e uma indicaÃ§Ã£o de onde o texto
completo se encontra.

<uma linha que forneÃ§a o nome do programa e uma idÃ©ia do que ele faz.>
Copyright (C) <ano>  <nome do autor>

Este programa Ã© software livre; vocÃª pode redistribuÃ­-lo e/ou
modificÃ¡-lo sob os termos da LicenÃ§a PÃºblica Geral GNU, conforme
publicada pela Free Software Foundation; tanto a versÃ£o 2 da
LicenÃ§a como (a seu critÃ©rio) qualquer versÃ£o mais nova.

Este programa Ã© distribuÃ­do na expectativa de ser Ãºtil, mas SEM
QUALQUER GARANTIA; sem mesmo a garantia implÃ­cita de
COMERCIALIZAÃÃO ou de ADEQUAÃÃO A QUALQUER PROPÃSITO EM
PARTICULAR. Consulte a LicenÃ§a PÃºblica Geral GNU para obter mais
detalhes.

VocÃª deve ter recebido uma cÃ³pia da LicenÃ§a PÃºblica Geral GNU
junto com este programa; se nÃ£o, escreva para a Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307, USA.

Inclua tambÃ©m informaÃ§Ãµes sobre como contactÃ¡-lo eletronicamente e por
carta.

Se o programa Ã© interativo, faÃ§a-o mostrar um aviso breve como este,
ao iniciar um modo interativo:

Gnomovision versÃ£o 69, Copyright (C) ano nome do autor
O Gnomovision nÃ£o possui QUALQUER GARANTIA; para obter mais
detalhes digite `show w'. Ele Ã© software livre e vocÃª estÃ¡
convidado a redistribui-lo sob certas condiÃ§Ãµes; digite `show c'
para obter detalhes.

Os comandos hipotÃ©ticos `show w' e `show c' devem mostrar as partes
apropriadas da LicenÃ§a PÃºblica Geral. Claro, os comandos que vocÃª usar
podem ser ativados de outra forma que `show w' e `show c'; eles podem
atÃ© ser cliques do mouse ou itens de um menu -- o que melhor se
adequar ao programa.

VocÃª tambÃ©m deve obter do seu empregador (se vocÃª trabalha como
programador) ou escola, se houver, uma "declaraÃ§Ã£o de ausÃªncia de
direitos autorais" sobre o programa, se necessÃ¡rio. Aqui estÃ¡ um
exemplo; altere os nomes:

Yoyodyne, Inc., aqui declara a ausÃªncia de quaisquer direitos
autorais sobre o programa `Gnomovision' (que executa interpretaÃ§Ãµes
em compiladores) escrito por James Hacker.

<assinatura de Ty Coon>, 1o. de abril de 1989
Ty Con, Vice-presidente

Esta LicenÃ§a PÃºblica Geral nÃ£o permite incorporar seu programa em
programas proprietÃ¡rios. Se seu programa Ã© uma biblioteca de
sub-rotinas, vocÃª deve considerar mais Ãºtil permitir ligar aplicaÃ§Ãµes
proprietÃ¡rias com a biblioteca. Se isto Ã© o que vocÃª deseja, use a
LicenÃ§a PÃºblica Geral de Bibliotecas GNU, ao invÃ©s desta LicenÃ§a.

*/

public class OmegaIndexer {
	private static Logger log = Logger.getLogger(OmegaIndexer.class);

	public static String extractFile(InputStream stream, String filename) {
	try {
                int idx = filename.lastIndexOf(".");
                String ret = null;

                if (idx==-1||stream==null) {
                	return null;
                }
                String ext = filename.substring(idx+1);

                if (ext.equalsIgnoreCase("pdf")) {
                        ret = extractPDF(stream, filename);
                } else  if (ext.equalsIgnoreCase("odt")||ext.equalsIgnoreCase("odp")||ext.equalsIgnoreCase("ods")||ext.equalsIgnoreCase("odg")) {
                	ret = extractODF(stream, filename);
                } else if (ext.equalsIgnoreCase("mm")) {
			ret = extractMM(stream, filename);
		} else if (ext.equalsIgnoreCase("dia")) {
			ret =  extractDia(stream, filename);
		} else if (ext.equalsIgnoreCase("txt")) {
			ret =  extractTxt(stream, filename);
		} else if (ext.equalsIgnoreCase("xml")) {
			ret =  extractXML(stream, filename);
		} else if (ext.equalsIgnoreCase("docx")) {
			ret = extractDOCX(stream, filename);
		} else if (ext.equalsIgnoreCase("pptx")||ext.equalsIgnoreCase("ppsx")) {
			ret = extractPPTX(stream, filename);
		} else if (ext.equalsIgnoreCase("xlsx")) {
			ret = extractXLSX(stream, filename);
		}
                if (ret!=null) {
                    return ret.replace('\u0000', ' ');
                }

	} catch(Throwable ex) {
		log.error(ex);
	}
        	return null;

        }
	
	
	private static String extractDOCX(InputStream stream, String filename) throws IOException {
                ZipInputStream zip = new ZipInputStream(stream);
		
		if (gotoFile(zip, "word/document.xml")) {
			return extractXML(zip, filename);
		} else return null;

	}
	
	private static String extractXLSX(InputStream stream, String filename) throws IOException {
                ZipInputStream zip = new ZipInputStream(stream);
		String str = "";
		int i = 1;
		
		if (gotoFile(zip, "xl/sharedStrings.xml")) {
			str += extractXML(zip, filename)+" ";
		} 
		
		do {
			stream.reset();
			zip = new ZipInputStream(stream);
			
			if (gotoFile(zip, "xl/worksheets/sheet"+i+".xml")) {
				str += extractXML(zip, filename)+" ";
				i++;
			} else break;
			
		} while(true);


		return str;
	}
	
	private static String extractPPTX(InputStream stream, String filename) throws IOException {
                ZipInputStream zip;
		int i=1;
		String str = "";
		boolean cont = false;
		
		do {
			stream.reset();
			zip = new ZipInputStream(stream);
			
			if (gotoFile(zip, "ppt/slides/slide"+i+".xml")) {
				str += extractXML(zip, filename)+" ";
				i++;
			} else break;
			
		} while (true);
		
		return str;

	}


	
	
        private static boolean gotoFile(ZipInputStream zip, String file)  throws IOException {
        	ZipEntry entry;
                while ((entry = zip.getNextEntry())!=null) {
                	if (entry.getName().equalsIgnoreCase(file)) {
                        	return true;
                        }
                }

                return false;
        }

	
	private static String extractXML(InputStream stream, String filename) throws IOException {
	try {

                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(stream);
		doc.getDocumentElement().normalize();

		return getText(doc.getDocumentElement());

	} catch(Exception ex) {
	
	}

        	return null;

        }     
	private static String extractTxt(InputStream stream, String filename) throws IOException {
		Reader reader = new InputStreamReader(new BufferedInputStream(stream));
		char []buf = new char[8192];
		int read;
		String str = "";
		
		while ((read = reader.read(buf))!=-1) {
			str += new String(buf, 0, read);
		}
		
		return str.replace("\n", " ").replace("\r", "");
	}

        private static String extractPDF(InputStream stream, String filename) throws IOException {
	/*
                               PdfReader pdf = new PdfReader(new BufferedInputStream(stream));
                               String ret = "";

	try {
        	int count = 1;
                while(true) {
			ret += PdfTextExtractor.getTextFromPage(pdf, count);
                	count++;
                }
	} catch(Throwable ex) {
	      log.error(ex);
	}

				return ret;
	*/
	String ret = null;
	try {
		PDDocument doc = PDDocument.load(new BufferedInputStream(stream));
		PDFTextStripper pdf = new PDFTextStripper();
		
		ret = pdf.getText(doc);
                
		
	} catch(IOException ex) {
		log.error(ex);
	}
	

         return ret;
        }


        private static String getText(Node node) {

        	if (node==null) {
                	return " ";
                }
                /*
        	String ret = " "+node.getTextContent();
                ret += " "+getText(node.getFirstChild());

                while( (node = node.getNextSibling())!=null) {
                	ret += " "+node.getTextContent();
	                ret += " "+getText(node.getFirstChild());
                }
                */
                String ret = "";

                do {
                        if (node.getFirstChild()!=null) {
                        	ret += " "+getText(node.getFirstChild());
			} else {
                        	ret += " "+node.getTextContent();
                        }
                } while( (node = node.getNextSibling())!=null);
                return ret;
        }

        private static boolean gotoContent(ZipInputStream zip)  throws IOException {
        	ZipEntry entry;

                while ((entry = zip.getNextEntry())!=null) {
                	if (entry.getName().equalsIgnoreCase("content.xml")) {
                        	return true;
                        }
                }

                return false;
        }

        private static String extractODF(InputStream stream, String filename) throws IOException {
	try {
                ZipInputStream zip = new ZipInputStream(new BufferedInputStream(stream));

                if (!gotoContent(zip)) {
                	return null;
                }

                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(zip);
		doc.getDocumentElement().normalize();

		return getText(doc.getDocumentElement());

	} catch(Exception ex) {
	
	}

        	return null;

        }
	
	private static String getMM(Node node) {
		if (node==null) {
			return "";
		}
	
		String str = "";
		
		do {
			String txt = null;
			Node child = node.getFirstChild();
			
			if (node instanceof Element) {
				txt = ((Element)node).getAttribute("TEXT");
			}
			
			if (txt!=null) {
				str += " "+txt;
			}
			
			if (child!=null) {
				str+= getMM(child);
			}
			
			if (node.getNodeName().equalsIgnoreCase("richcontent")) {
				str+= getText(node);
			} 
			
		} while ((node = node.getNextSibling())!=null);
		
		return str;
	}
	
	private static String extractMM(InputStream stream, String filename) throws IOException {
	try {
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(stream);
		doc.getDocumentElement().normalize();
         
		String ret = getMM(doc.getDocumentElement()); 
		
		//log.error(ret);
		return ret;
	} catch(Exception ex) {
		log.error(ex);
		return null;
	}
	}


	private static String getDia(Node node) {
		if (node==null) {
			return "";
		}
	
		String str = "";
		
		do {
			String txt = null;
			Node child = node.getFirstChild();
			
			if (node.getNodeName().equalsIgnoreCase("dia:string")) {
				txt = node.getTextContent();
			}
			
			if (txt!=null&&txt.length()>2) {
				if (txt.startsWith("#")&&txt.endsWith("#")) {
					str += " "+txt.substring(1, txt.length()-1);
				} else {
					str += " "+txt;
				}
			}
			
			if (child!=null) {
				str+= getDia(child);
			}
			
			
		} while ((node = node.getNextSibling())!=null);
		
		return str;
	}

	private static String extractDia(InputStream stream, String filename) throws IOException {
	try {
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		Document doc = dBuilder.parse(new java.util.zip.GZIPInputStream(stream));
		doc.getDocumentElement().normalize();
         
		String ret = getDia(doc.getDocumentElement()); 
		
		//log.error(ret);
		//log.error(ret);
		return ret;
	} catch(Exception ex) {
		log.error(ex);
		return null;
	}
	}
        

	public static void main(String []args) {
	try {
	       BufferedInputStream buf = new BufferedInputStream(new FileInputStream("/"));
               String ee = extractFile(buf, "mentar.mm");

               //javax.swing.JOptionPane.showMessageDialog(null, ee);
		java.util.StringTokenizer token = new java.util.StringTokenizer(ee);

                while(token.hasMoreTokens()) {
                	System.out.println(token.nextToken()+"\n");
                }

	} catch(Exception ex) {
	       log.error(ex);
	}
	
	}

}
