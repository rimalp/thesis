%CREATE TEMPLATES
%Letter


A=imread('symbols/capital-A.bmp');B=imread('symbols/capital-B.bmp');
C=imread('symbols/capital-C.bmp');D=imread('symbols/capital-D.bmp');
E=imread('symbols/capital-E.bmp');F=imread('symbols/capital-F.bmp');
G=imread('symbols/capital-G.bmp');H=imread('symbols/capital-H.bmp');
I=imread('symbols/capital-I.bmp');J=imread('symbols/capital-J.bmp');
K=imread('symbols/capital-K.bmp');L=imread('symbols/capital-L.bmp');
M=imread('symbols/capital-M.bmp');N=imread('symbols/capital-N.bmp');
O=imread('symbols/capital-O.bmp');P=imread('symbols/capital-P.bmp');
Q=imread('symbols/capital-Q.bmp');R=imread('symbols/capital-R.bmp');
S=imread('symbols/capital-S.bmp');T=imread('symbols/capital-T.bmp');
U=imread('symbols/capital-U.bmp');V=imread('symbols/capital-V.bmp');
W=imread('symbols/capital-W.bmp');X=imread('symbols/capital-X.bmp');
Y=imread('symbols/capital-Y.bmp');Z=imread('symbols/capital-Z.bmp');

a=imread('symbols/small-a.bmp');b=imread('symbols/small-b.bmp');
c=imread('symbols/small-c.bmp');d=imread('symbols/small-d.bmp');
e=imread('symbols/small-e.bmp');f=imread('symbols/small-f.bmp');
g=imread('symbols/small-g.bmp');h=imread('symbols/small-h.bmp');
i=imread('symbols/small-i.bmp');j=imread('symbols/small-j.bmp');
k=imread('symbols/small-k.bmp');l=imread('symbols/small-l.bmp');
m=imread('symbols/small-m.bmp');n=imread('symbols/small-n.bmp');
o=imread('symbols/small-o.bmp');p=imread('symbols/small-p.bmp');
q=imread('symbols/small-q.bmp');r=imread('symbols/small-r.bmp');
s=imread('symbols/small-s.bmp');t=imread('symbols/small-t.bmp');
u=imread('symbols/small-u.bmp');v=imread('symbols/small-v.bmp');
w=imread('symbols/small-w.bmp');x=imread('symbols/small-x.bmp');
y=imread('symbols/small-y.bmp');z=imread('symbols/small-z.bmp');

func_a = imread('symbols/func-a.bmp');func_c = imread('symbols/func-c.bmp');
func_i = imread('symbols/func-i.bmp');func_l = imread('symbols/func-l.bmp');
func_m = imread('symbols/func-m.bmp');func_n = imread('symbols/func-n.bmp');
func_o = imread('symbols/func-o.bmp');func_s = imread('symbols/func-s.bmp');
func_t = imread('symbols/func-t.bmp');

%Number
one=imread('symbols/1.bmp');  two=imread('symbols/2.bmp');
three=imread('symbols/3.bmp');four=imread('symbols/4.bmp');
five=imread('symbols/5.bmp'); six=imread('symbols/6.bmp');
seven=imread('symbols/7.bmp');eight=imread('symbols/8.bmp');
nine=imread('symbols/9.bmp'); zero=imread('symbols/0.bmp');

one2=imread('symbols/one.bmp');  two2=imread('symbols/two.bmp');
three2=imread('symbols/three.bmp');four2=imread('symbols/four.bmp');
five2=imread('symbols/five.bmp'); six2=imread('symbols/six.bmp');
seven2=imread('symbols/seven.bmp');eight2=imread('symbols/eight.bmp');
nine2=imread('symbols/nine.bmp'); zero2=imread('symbols/zero.bmp');
one3 =imread('symbols/one2.bmp');

%Sign
sigma = imread('symbols/sigma.bmp');
integral = imread('symbols/integral.bmp');
plus = imread('symbols/plus.bmp');
minus = imread('symbols/minus.bmp');
division = imread('symbols/division.bmp');
dot = imread('symbols/dot.bmp');
alpha = imread('symbols/alpha.bmp');
beta = imread('symbols/beta.bmp');
gamma = imread('symbols/gamma.bmp');
delta = imread('symbols/delta.bmp');
epsilon = imread('symbols/epsilon.bmp');
pi = imread('symbols/pi.bmp');
smallSig = imread('symbols/smallSig.bmp');
theta = imread('symbols/theta.bmp');
star = imread('symbols/star.bmp');
smaller = imread('symbols/smaller.bmp');
sqrt = imread('symbols/sqrt.bmp');
sqrt2 = imread('symbols/sqrt2.bmp');
sqrt3 = imread('symbols/sqrt3.bmp');
lparen = imread('symbols/lparen.bmp');
rparen = imread('symbols/rparen.bmp');
lSQRparen = imread('symbols/lSQRparen.bmp');
rSQRparen = imread('symbols/rSQRparen.bmp');
lCRLparen = imread('symbols/lCRLparen.bmp');
rCRLparen = imread('symbols/rCRLparen.bmp');
lDOWNVALparen = imread('symbols/lDOWNVALparen.bmp');
rDOWNVALparen = imread('symbols/rDOWNVALparen.bmp');
lUPVALparen = imread('symbols/lUPVALparen.bmp');
rUPVALparen = imread('symbols/rUPVALparen.bmp');
mult = imread('symbols/mult.bmp');
infinity = imread('symbols/infinity.bmp');
arrow = imread('symbols/arrow.bmp');
derive = imread('symbols/derive.bmp');
quote = imread('symbols/quote.bmp');
lambda = imread('symbols/lambda.bmp');
fact = imread('symbols/fact.bmp');
fact2 = imread('symbols/fact2.bmp');
slash = imread('symbols/slash.bmp');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d...
    e f g h i j k l m n o p q r s t u v w x y z func_a func_c func_i func_l func_m func_n func_o func_s func_t];
number=[one two three four five six seven eight nine zero...
	one2 two2 three2 four2 five2 six2 seven2 eight2 nine2 zero2 one3];
sign = [sigma integral plus minus division dot alpha beta gamma delta epsilon pi smallSig theta...
    star smaller sqrt sqrt2 sqrt3 lparen rparen mult infinity arrow derive quote lambda fact fact2 slash];
character=[letter number sign];
templates=mat2cell(character,42,[24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
	24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
	24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
	24 24 24 24 24 24 24 24 24 24 24 24 24 24 24 ...
	24 24 24 24 24 24 24]);
save ('templates','templates')
clear all
