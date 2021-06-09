unit Unit1;

interface

//dziala wszystko dla zmienno, przerobic na intervala
//poprawic wektory na dynamiczne, trzeba dodac to pamieci (setlength) bo teraz statycxzne w inputach

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, IntervalArithmetic32and64;
//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
//  System.Classes, Vcl.Graphics,
//  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IntervalArithmetic32and64,
//  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    x_list: TListBox;
    f_list: TListBox;
    output_list: TListBox;
    x_add: TButton;
    f_add: TButton;
    value_button: TButton;
    x_input: TEdit;
    f_input: TEdit;
    st_output: TEdit;
    x_label: TLabel;
    f_label: TLabel;
    st_label: TLabel;
    i_output_label: TLabel;
    xx_label: TLabel;
    xx_input: TEdit;
    clear_button: TButton;
    coeffns_button: TButton;
    i_x_list: TListBox;
    i_f_list: TListBox;
    i_output_list: TListBox;
    i_x_add: TButton;
    i_f_add: TButton;
    i_value_button: TButton;
    xa_input: TEdit;
    i_st_output: TEdit;
    xa_label: TLabel;
    i_st_label: TLabel;
    output_label: TLabel;
    xxa_label: TLabel;
    xxa_input: TEdit;
    i_coeffns_button: TButton;
    xb_input: TEdit;
    xb_label: TLabel;
    fa_input: TEdit;
    fb_input: TEdit;
    fb_label: TLabel;
    fa_label: TLabel;
    xxb_input: TEdit;
    xxb_label: TLabel;
    n_input: TEdit;
    n_button: TButton;
    n_label: TLabel;
    przyklad1_a_b: TButton;
    n_list: TListBox;
    przyklad2_intread: TButton;
    przyklad1_intread: TButton;
    przyklad2_a_b: TButton;
    procedure x_addClick(Sender: TObject);
    procedure value_buttonClick(Sender: TObject);
    procedure f_addClick(Sender: TObject);
    procedure clear_buttonClick(Sender: TObject);
    procedure coeffns_buttonClick(Sender: TObject);
    procedure i_f_addClick(Sender: TObject);
    procedure i_x_addClick(Sender: TObject);
    procedure i_value_buttonClick(Sender: TObject);
    procedure i_coeffns_buttonClick(Sender: TObject);
    procedure n_buttonClick(Sender: TObject);
    procedure przyklad1_a_bClick(Sender: TObject);
    procedure przyklad2_intreadClick(Sender: TObject);
    procedure przyklad2_a_bClick(Sender: TObject);
    procedure przyklad1_intreadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  type
  vector  = array of Extended;
  vector1 = array of Extended;
  vector2 = array of Extended;
  vector3 = array of Extended;
  matrix  = array of array of Extended;

  ivector  = array of Interval;
  ivector1 = array of Interval;
  ivector2 = array of Interval;
  ivector3 = array of Interval;
  imatrix  = array of array of Interval;


var
  Form1                 : TForm1;
  x, f                  : vector;
  xx, res               : Extended;
  st, i_st, n, n_f, n_x : Integer;
  a                     : matrix;
  interval_x,interval_f : ivector;
  i_x, i_f              : ivector;
  i_xx, i_result        : Interval;
  i_n, i_n_x, i_n_f     : Integer;
  i_a                   : imatrix;
  interval_a            : imatrix;


implementation

procedure periodsplinecoeffns (n         : Integer;
                               x,f       : vector;
                               var a     : matrix;
                               var st    : Integer);

var i,k        : Integer;
    w,v,y,z,xi : Extended;
    u          : vector;
    b,c,d      : vector1;
    p          : vector2;
    q          : vector3;
begin

   SetLength(u,n + 1);
   SetLength(b,n + 1);
   SetLength(c,n + 1);
   SetLength(d,n + 1);
   SetLength(p,n + 1);
   SetLength(q,n + 1);

  if n<1
    then st:=1
    else if f[0]<>f[n]
           then st:=3
           else begin
                  st:=0;
                  i:=-1;
                  repeat
                    i:=i+1;
                    for k:=i+1 to n do
                      if x[i]=x[k]
                        then st:=2
                  until (i=n-1) or (st=2)
                end;
  if st=0
    then begin
           if n>1
             then begin
                    v:=x[1]-x[0];
                    z:=x[n]-x[n-1];
                    b[n]:=v/(z+v);
                    c[n]:=1-b[n];
                    y:=f[n];
                    d[n]:=6*((f[1]-y)/v-(y-f[n-1])/z)/(z+v);
                    for i:=1 to n-1 do
                      begin
                        z:=x[i];
                        y:=x[i+1]-z;
                        z:=z-x[i-1];
                        v:=f[i];
                        b[i]:=y/(y+z);
                        c[i]:=1-b[i];
                        d[i]:=6*((f[i+1]-v)/y-(v-f[i-1])/z)/(y+z)
                      end;
                    if n>2
                      then begin
                             u[1]:=2;
                             c[2]:=c[2]/2;
                             q[2]:=-b[n]/2;
                             for i:=2 to n-2 do
                               begin
                                 v:=2-b[i-1]*c[i];
                                 c[i+1]:=c[i+1]/v;
                                 q[i+1]:=-q[i]*b[i-1]/v;
                                 u[i]:=v
                               end;
                             v:=2-c[n-1]*b[n-2];
                             q[n]:=(c[n]-q[n-1]*b[n-2])/v;
                             u[n-1]:=v;
                             p[1]:=c[1];
                             for i:=2 to n-2 do
                               p[i]:=-c[i]*p[i-1];
                             p[n-1]:=b[n-1]-c[n-1]*p[n-2];
                             v:=2-c[1]*p[2];
                             for i:=2 to n-2 do
                               v:=v-p[i]*p[i+1];
                             u[n]:=v-p[n-1]*q[n];
                             for i:=2 to n-1 do
                               d[i]:=d[i]-c[i]*d[i-1];
                             v:=d[n];
                             for i:=2 to n do
                               v:=v-q[i]*d[i-1];
                             d[n]:=v;
                             u[n]:=d[n]/u[n];
                             u[n-1]:=(d[n-1]-p[n-1]*u[n])/u[n-1];
                             for i:=n-2 downto 1 do
                               u[i]:=(d[i]-b[i]*u[i+1]-p[i]*u[n])/u[i]
                           end
                      else begin
                             y:=d[1];
                             z:=d[2];
                             w:=4-c[2]*b[1];
                             u[1]:=(2*y-b[1]*z)/w;
                             u[2]:=(2*z-c[2]*y)/w;
                           end
                  end
             else u[1]:=0;
           u[0]:=u[n];
           for i:=0 to n-1 do
             begin
               w:=f[i];
               xi:=x[i];
               z:=x[i+1]-xi;
               y:=u[i];
               v:=(f[i+1]-w)/z-(2*y+u[i+1])*z/6;
               z:=(u[i+1]-y)/(6*z);
               y:=y/2;
               a[0,i]:=((-z*xi+y)*xi-v)*xi+w;
               w:=3*z*xi;
               a[1,i]:=(w-2*y)*xi+v;
               a[2,i]:=y-w;
               a[3,i]:=z
             end
         end;

     Finalize(u);
     Finalize(b);
     Finalize(c);
     Finalize(d);
     Finalize(p);
     Finalize(q);
end;


function periodsplinevalue (n      : Integer;
                            x,f    : vector;
                            xx     : Extended;
                            var st : Integer) : Extended;

var i,k   : Integer;
    v,y,z : Extended;
    found : Boolean;
    a     : array [0..3] of Extended;
    u     : vector;
    b,c,d : vector1;
    p     : vector2;
    q     : vector3;
begin
      SetLength(u,n + 1);
      SetLength(b,n + 1);
      SetLength(c,n + 1);
      SetLength(d,n + 1);
      SetLength(p,n + 1);
      SetLength(q,n + 1);

  if n<1
    then st:=1
    else if f[0]<>f[n]
           then st:=3
           else if (xx<x[0]) or (xx>x[n])
                  then st:=4
                  else begin
                         st:=0;
                         i:=-1;
                         repeat
                           i:=i+1;
                           for k:=i+1 to n do
                             if x[i]=x[k]
                               then st:=2
                         until (i=n-1) or (st=2)
                       end;
  if st=0
    then begin
           if n>1
             then begin
                    v:=x[1]-x[0];
                    z:=x[n]-x[n-1];
                    b[n]:=v/(z+v);
                    c[n]:=1-b[n];
                    y:=f[n];
                    d[n]:=6*((f[1]-y)/v-(y-f[n-1])/z)/(z+v);
                    for i:=1 to n-1 do
                      begin
                        z:=x[i];
                        y:=x[i+1]-z;
                        z:=z-x[i-1];
                        v:=f[i];
                        b[i]:=y/(y+z);
                        c[i]:=1-b[i];
                        d[i]:=6*((f[i+1]-v)/y-(v-f[i-1])/z)/(y+z)
                      end;
                    if n>2
                      then begin
                             u[1]:=2;
                             c[2]:=c[2]/2;
                             q[2]:=-b[n]/2;
                             for i:=2 to n-2 do
                               begin
                                 v:=2-b[i-1]*c[i];
                                 c[i+1]:=c[i+1]/v;
                                 q[i+1]:=-q[i]*b[i-1]/v;
                                 u[i]:=v
                               end;
                             v:=2-c[n-1]*b[n-2];
                             q[n]:=(c[n]-q[n-1]*b[n-2])/v;
                             u[n-1]:=v;
                             p[1]:=c[1];
                             for i:=2 to n-2 do
                               p[i]:=-c[i]*p[i-1];
                             p[n-1]:=b[n-1]-c[n-1]*p[n-2];
                             v:=2-c[1]*p[2];
                             for i:=2 to n-2 do
                               v:=v-p[i]*p[i+1];
                             u[n]:=v-p[n-1]*q[n];
                             for i:=2 to n-1 do
                               d[i]:=d[i]-c[i]*d[i-1];
                             v:=d[n];
                             for i:=2 to n do
                               v:=v-q[i]*d[i-1];
                             d[n]:=v;
                             u[n]:=d[n]/u[n];
                             u[n-1]:=(d[n-1]-p[n-1]*u[n])/u[n-1];
                             for i:=n-2 downto 1 do
                               u[i]:=(d[i]-b[i]*u[i+1]-p[i]*u[n])/u[i]
                           end
                      else begin
                             y:=d[1];
                             z:=d[2];
                             v:=4-c[2]*b[1];
                             u[1]:=(2*y-b[1]*z)/v;
                             u[2]:=(2*z-c[2]*y)/v;
                           end
                  end
             else u[1]:=0;
           u[0]:=u[n];
           found:=False;
           i:=-1;
           repeat
             i:=i+1;
             if (xx>=x[i]) and (xx<=x[i+1])
               then found:=True
           until found;
           y:=x[i+1]-x[i];
           z:=u[i+1];
           v:=u[i];
           a[0]:=f[i];
           a[1]:=(f[i+1]-f[i])/y-(2*v+z)*y/6;
           a[2]:=v/2;
           a[3]:=(z-v)/(6*y);
           y:=a[3];
           z:=xx-x[i];
           for i:=2 downto 0 do
             y:=y*z+a[i];
           periodsplinevalue:=y
         end;

     Finalize(u);
     Finalize(b);
     Finalize(c);
     Finalize(d);
     Finalize(p);
     Finalize(q);
end;


procedure iperiodsplinecoeffns (n         : Integer;
                               x,f       : ivector;
                               var i_a     : imatrix;
                               var st    : Integer);

var i,k        : Integer;
    w,v,y,z,xi : Interval;
    u          : ivector;
    b,c,d      : ivector1;
    p          : ivector2;
    q          : ivector3;
begin

   SetLength(u,n + 1);
   SetLength(b,n + 1);
   SetLength(c,n + 1);
   SetLength(d,n + 1);
   SetLength(p,n + 1);
   SetLength(q,n + 1);
   SetLength(i_a,4,n + 1);

  if n<1
    then st:=1
      else if differ(f[0], f[n])
           then st:=3
           else begin
                  st:=0;
                  i:=-1;
                  repeat
                    i:=i+1;
                    for k:=i+1 to n do
                      if ((i_x[i].a=i_x[k].a) AND (i_x[i].b=i_x[k].b))
                        then st:=2
                  until (i=n-1) or (st=2)
                end;
  if st=0
    then begin

           if n>1
             then begin
                    v:=isub(i_x[1],i_x[0]);
                    z:=isub(i_x[n],i_x[n-1]);
                    b[n]:=idiv(v,iadd(z,v));
                    c[n]:=isub(int_read('1'),b[n]);
                    y:=i_f[n];
                    d[n]:=idiv(imul(int_read('6'),isub(idiv(isub(i_f[1],y),v),idiv(isub(y,i_f[n-1]),z))),iadd(z,v));
                    for i:=1 to n-1 do
                      begin
                        z:=i_x[i];
                        y:=isub(i_x[i+1],z);
                        z:=isub(z,i_x[i-1]);
                        v:=i_f[i];
                        b[i]:=idiv(y,iadd(y,z));
                        c[i]:=isub(int_read('1'),b[i]);
                        d[i]:=idiv(imul(int_read('6'),isub(idiv(isub(f[i+1],v),y),idiv(isub(v,f[i-1]),z))),iadd(y,z))
                      end;
                    if n>2
                      then begin
                             u[1]:=int_read('2');
                             c[2]:=idiv(c[2],int_read('2'));
                             q[2]:=isub(int_read('0'),idiv(b[n],int_read('2')));
                             for i:=2 to n-2 do
                               begin
                                 v:=isub(int_read('2'),imul(b[i-1],c[i]));
                                 c[i+1]:=idiv(c[i+1],v);
                                 q[i+1]:=isub(int_read('0'),idiv(imul(q[i],b[i-1]),v));
                                 u[i]:=v
                               end;
                             v:=isub(int_read('2'),imul(c[n-1],b[n-2]));
                             q[n]:=idiv(isub(c[n],imul(q[n-1],b[n-2])),v);
                             u[n-1]:=v;
                             p[1]:=c[1];
                             for i:=2 to n-2 do
                               p[i]:=isub(int_read('0'),imul(c[i],p[i-1]));
                             p[n-1]:=isub(b[n-1],imul(c[n-1],p[n-2]));
                             v:=isub(int_read('2'),imul(c[1],p[2]));
                             for i:=2 to n-2 do
                               v:=isub(v,imul(p[i],p[i+1]));
                             u[n]:=isub(v,imul(p[n-1],q[n]));
                             for i:=2 to n-1 do
                               d[i]:=isub(d[i],imul(c[i],d[i-1]));
                             v:=d[n];
                             for i:=2 to n do
                               v:=isub(v,imul(q[i],d[i-1]));
                             d[n]:=v;
                             u[n]:=idiv(d[n],u[n]);
                             u[n-1]:=idiv(isub(d[n-1],imul(p[n-1],u[n])),u[n-1]);
                             for i:=n-2 downto 1 do
                               u[i]:=idiv(isub(isub(d[i],imul(b[i],u[i+1])),imul(p[i],u[n])),u[i]);
                           end
                      else begin
                             y:=d[1];
                             z:=d[2];
                             w:=isub(int_read('4'),imul(c[2],b[1]));
                             u[1]:=idiv(isub(imul(int_read('2'),y),imul(b[1],z)),w);
                             u[2]:=idiv(isub(imul(int_read('2'),z),imul(c[2],y)),w);
                           end
                  end
             else u[1]:=int_read('0');
           u[0]:=u[n];
           for i:=0 to n-1 do
             begin
               w:=i_f[i];
               xi:=i_x[i];
               z:=isub(i_x[i+1],xi);
               y:=u[i];
               v:=isub(idiv(isub(f[i+1],w),z),idiv(imul(iadd(imul(int_read('2'),y),u[i+1]),z),int_read('6')));
               z:=idiv(isub(u[i+1],y),imul(int_read('6'),z));
               y:=idiv(y,int_read('2'));
               i_a[0,i]:=iadd(imul(isub(imul(iadd(imul(isub(int_read('0'),z),xi),y),xi),v),xi),w);
               w:=imul(imul(int_read('3'),z),xi);
               i_a[1,i]:=iadd(imul(isub(w,imul(int_read('2'),y)),xi),v);
               i_a[2,i]:=isub(y,w);
               i_a[3,i]:=z
             end
         end;

         Finalize(u);
         Finalize(b);
         Finalize(c);
         Finalize(d);
         Finalize(p);
         Finalize(q);
end;


function iperiodsplinevalue (n      : Integer;
                            i_x,i_f    : ivector;
                            i_xx     : Interval;
                            var st : Integer) : Interval;

var i,k   : Integer;
    v,y,z : Interval;
    found : Boolean;
    a     : array [0..3] of Interval;
    u     : ivector;
    b,c,d : ivector1;
    p     : ivector2;
    q     : ivector3;

begin

  SetLength(u,n + 1);
  SetLength(b,n + 1);
  SetLength(c,n + 1);
  SetLength(d,n + 1);
  SetLength(p,n + 1);
  SetLength(q,n + 1);

  if n<1
    then st:=1
    else if differ(i_f[0], i_f[n])
           then st:=3
           else if (less(i_xx, i_x[0])) or (greater(i_xx, i_x[n]))
                  then st:=4
                  else begin
                         st:=0;
                         i:=-1;
                         repeat
                           i:=i+1;
                           for k:=i+1 to n do
                                if equal(i_x[i], i_x[k])
                               then st:=2
                         until (i=n-1) or (st=2)
                       end;

  if st=0
    then begin
           if n>1
             then begin
                    v:=isub(i_x[1],i_x[0]);
                    z:=isub(i_x[n],i_x[n-1]);
                    b[n]:=idiv(v,iadd(z,v));
                    c[n]:=isub(int_read('1'),b[n]);
                    y:=i_f[n];
                    d[n]:=imul(int_read('6'),idiv(isub(idiv(isub(i_f[1],y),v),idiv(isub(y,i_f[n-1]),z)),iadd(z,v)));
                    for i:=1 to n-1 do
                      begin
                        z:=i_x[i];
                        y:=isub(i_x[i+1],z);
                        z:=isub(z,i_x[i-1]);
                        v:=i_f[i];
                        b[i]:=idiv(y,iadd(y,z));
                        c[i]:=isub(int_read('1'),b[i]);
                        d[i]:=imul(int_read('6'),idiv(isub(idiv(isub(i_f[i+1],v),y),idiv(isub(v,i_f[i-1]),z)),iadd(y,z)));
                      end;
                    if n>2
                      then begin
                             u[1]:=int_read('2');
                             c[2]:=idiv(c[2],int_read('2'));
                             q[2]:=isub(int_read('0'),idiv(b[n],int_read('2')));
                             for i:=2 to n-2 do
                               begin
                                 v:=isub(int_read('2'),imul(b[i-1],c[i]));
                                 c[i+1]:=idiv(c[i+1],v);
                                 q[i+1]:=isub(int_read('0'),idiv(imul(q[i],b[i-1]),v));
                                 u[i]:=v
                               end;
                             v:=isub(int_read('2'),imul(c[n-1],b[n-2]));
                             q[n]:=idiv(isub(c[n],imul(q[n-1],b[n-2])),v);
                             u[n-1]:=v;
                             p[1]:=c[1];
                             for i:=2 to n-2 do
                               p[i]:=isub(int_read('0'),imul(c[i],p[i-1]));
                             p[n-1]:=isub(b[n-1],imul(c[n-1],p[n-2]));
                             v:=isub(int_read('2'),imul(c[1],p[2]));
                             for i:=2 to n-2 do
                             v:=isub(v,imul(p[i],p[i+1]));
                             u[n]:=isub(v,imul(p[n-1],q[n]));
                             for i:=2 to n-1 do
                               d[i]:=isub(d[i],imul(c[i],d[i-1]));
                             v:=d[n];
                             for i:=2 to n do
                               v:=isub(v,imul(q[i],d[i-1]));
                             d[n]:=v;
                             u[n]:=idiv(d[n],u[n]);
                             u[n-1]:=idiv(isub(d[n-1],imul(p[n-1],u[n])),u[n-1]);
                             for i:=n-2 downto 1 do
                               u[i]:=idiv(isub(isub(d[i],imul(b[i],u[i+1])),imul(p[i],u[n])),u[i]);
                           end
                      else begin
                             y:=d[1];
                             z:=d[2];
                             v:=isub(int_read('4'),imul(c[2],b[1]));
                             u[1]:=idiv(isub(imul(int_read('2'),y),imul(b[1],z)),v);
                             u[2]:=idiv(isub(imul(int_read('2'),z),imul(c[2],y)),v);
                           end
                  end
             else u[1]:=int_read('0');
           u[0]:=u[n];
           found:=False;
           i:=-1;
           repeat
             i:=i+1;
//             if (i_xx.a>=i_x[i].b) and (i_xx.b<=i_x[i+1].a)
               if (greater(i_xx, i_x[i]) or equal(i_xx, i_x[i])) and (less(i_xx, i_x[i+1]) or equal(i_xx, i_x[i+1]))
               then found:=True
           until found;
           y:=isub(i_x[i+1],i_x[i]);
           z:=u[i+1];
           v:=u[i];
           a[0]:=i_f[i];
           a[1]:=isub(idiv(isub(i_f[i+1],i_f[i]),y),idiv(imul(iadd(imul(int_read('2'),v),z),y),int_read('6')));
           a[2]:=idiv(v,int_read('2'));
           a[3]:=idiv(isub(z,v),imul(int_read('6'),y));
           y:=a[3];
           z:=isub(i_xx,i_x[i]);
           for i:=2 downto 0 do
             y:=iadd(imul(y,z),a[i]);
           iperiodsplinevalue:=y;
         end;

     Finalize(u);
     Finalize(b);
     Finalize(c);
     Finalize(d);
     Finalize(p);
     Finalize(q);
end;


{$R *.dfm}


procedure TForm1.n_buttonClick(Sender: TObject);
begin
  n := StrToInt(n_input.Text);

  n_list.Items.Add('liczba wêz³ów: ' + IntToStr(n));
  n_list.Items.Add('n =  ' + IntToStr(n-1));

  st := 0;
  i_st := 0;
  SetLength(x,n + 1);
  SetLength(f,n + 1);
  SetLength(i_x,n + 1);
  SetLength(i_f,n + 1);
  SetLength(interval_x,n + 1);
  SetLength(interval_f,n + 1);
  SetLength(a,4,n);
  SetLength(interval_a,4,n);
  SetLength(i_a,4,n);
end;

procedure TForm1.przyklad1_a_bClick(Sender: TObject);
var
i, j : Integer;
lewy, prawy : String;
begin

  n := 2;
  i_st := 0;

  SetLength(i_x,n + 1);
  SetLength(i_f,n + 1);
  SetLength(i_a,4,n);

//  i_x[0] := int_read('0');
//  i_x[1] := int_read('1');
//
//  i_f[0] := int_read('1');
//  i_f[1] := int_read('1');
//
//  i_xx := int_read('0,5');

  i_x[0].a := -0.01;
  i_x[0].b := 0.01;
  i_x[1].a := 0.99;
  i_x[1].b := 1.01;

  i_f[0].a := 0.99;
  i_f[0].b := 1.01;
  i_f[1].a := 0.99;
  i_f[1].b := 1.01;

  i_xx.a := 0.49;
  i_xx.b := 0.51;


   i_result := iperiodsplinevalue(n-1, i_x, i_f, i_xx, i_st);

//  i_output_list.Items.Add('y = [' + FloatToStr(i_result.a) + '] [' + FloatToStr(i_result.b) + ']');
//
  iends_to_strings(i_result, lewy, prawy);
  i_output_list.Items.Add('y = [' + lewy + '] [' + prawy + ']');

  i_st_output.text := IntToStr(st);

  i_output_list.Items.Add('szerokosc przedzialu = ' + FloatToStr(int_width(i_result)));

//  showMessage('teraz wspolczynniki');

  iperiodsplinecoeffns(n - 1, i_x, i_f, i_a, i_st);

  for i := 0 to 3 do
  begin
    for j := 0 to n - 2 do
    begin
//      i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
//        FloatToStr(i_a[i][j].a) + ', ' + FloatToStr(i_a[i][j].b) + ']');
         iends_to_strings(i_a[i][j], lewy, prawy);
         i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
         lewy + ', ' + prawy + ']');
    end;
  end;

  i_st_output.text := IntToStr(i_st);
end;

procedure TForm1.przyklad1_intreadClick(Sender: TObject);
var
i, j : Integer;
lewy, prawy : String;
begin

  n := 2;
  i_st := 0;

  SetLength(i_x,n + 1);
  SetLength(i_f,n + 1);
  SetLength(i_a,4,n);

  i_x[0] := int_read('0');
  i_x[1] := int_read('1');

  i_f[0] := int_read('1');
  i_f[1] := int_read('1');

  i_xx := int_read('0,5');

   i_result := iperiodsplinevalue(n-1, i_x, i_f, i_xx, i_st);

//  i_output_list.Items.Add('y = [' + FloatToStr(i_result.a) + '] [' + FloatToStr(i_result.b) + ']');
//
  iends_to_strings(i_result, lewy, prawy);
  i_output_list.Items.Add('y = [' + lewy + '] [' + prawy + ']');

  i_st_output.text := IntToStr(st);

  i_output_list.Items.Add('szerokosc przedzialu = ' + FloatToStr(int_width(i_result)));

//  showMessage('teraz wspolczynniki');

  iperiodsplinecoeffns(n - 1, i_x, i_f, i_a, i_st);

  for i := 0 to 3 do
  begin
    for j := 0 to n - 2 do
    begin
//      i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
//        FloatToStr(i_a[i][j].a) + ', ' + FloatToStr(i_a[i][j].b) + ']');
         iends_to_strings(i_a[i][j], lewy, prawy);
         i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
         lewy + ', ' + prawy + ']');
    end;
  end;

  i_st_output.text := IntToStr(i_st);
end;

procedure TForm1.przyklad2_a_bClick(Sender: TObject);
var
i, j : Integer;
lewy, prawy : String;
begin

  n := 3;
  i_st := 0;

  SetLength(i_x,n + 1);
  SetLength(i_f,n + 1);
  SetLength(i_a,4,n);

  i_x[0].a := -0.01;
  i_x[0].b := 0.01;
  i_x[1].a := 0.99;
  i_x[1].b := 1.01;
  i_x[2].a := 1.99;
  i_x[2].b := 2.01;


  i_f[0].a := 0.99;
  i_f[0].b := 1.01;
  i_f[1].a := -0.01;
  i_f[1].b := 0.01;
  i_f[2].a := 0.99;
  i_f[2].b := 1.01;

  i_xx.a := 0.99;
  i_xx.b := 1.01;

  i_result := iperiodsplinevalue(n-1, i_x, i_f, i_xx, i_st);

  iends_to_strings(i_result, lewy, prawy);
  i_output_list.Items.Add('y = [' + lewy + '] [' + prawy + ']');

  i_st_output.text := IntToStr(st);

  i_output_list.Items.Add('szerokosc przedzialu = ' + FloatToStr(int_width(i_result)));

//  showMessage('teraz wspolczynniki');

  iperiodsplinecoeffns(n - 1, i_x, i_f, i_a, i_st);

  for i := 0 to 3 do
  begin
    for j := 0 to n - 2 do
    begin
         iends_to_strings(i_a[i][j], lewy, prawy);
         i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
         lewy + ', ' + prawy + ']');
    end;
  end;

  i_st_output.text := IntToStr(st);

end;


procedure TForm1.przyklad2_intreadClick(Sender: TObject);
var
i, j : Integer;
lewy, prawy : String;
begin

  n := 3;
  i_st := 0;

  SetLength(i_x,n + 1);
  SetLength(i_f,n + 1);
  SetLength(i_a,4,n);

  i_x[0] := int_read('0');
  i_x[1] := int_read('1');
  i_x[2] := int_read('2');

  i_f[0] := int_read('1');
  i_f[1] := int_read('0');
  i_f[2] := int_read('1');

  i_xx := int_read('1');


  i_result := iperiodsplinevalue(n-1, i_x, i_f, i_xx, i_st);

  iends_to_strings(i_result, lewy, prawy);
  i_output_list.Items.Add('y = [' + lewy + '] [' + prawy + ']');

  i_st_output.text := IntToStr(st);

  i_output_list.Items.Add('szerokosc przedzialu = ' + FloatToStr(int_width(i_result)));

//  showMessage('teraz wspolczynniki');

  iperiodsplinecoeffns(n - 1, i_x, i_f, i_a, i_st);

  for i := 0 to 3 do
  begin
    for j := 0 to n - 2 do
    begin
         iends_to_strings(i_a[i][j], lewy, prawy);
         i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
         lewy + ', ' + prawy + ']');
    end;
  end;

  i_st_output.text := IntToStr(st);
end;


procedure TForm1.x_addClick(Sender: TObject);
begin
  x[n_x] := StrToFloat(x_input.text);

  x_list.Items.Add('x[' + IntToStr(n_x) + '] = ' + x_input.text);

  n_x := n_x + 1;
  x_input.Clear();
end;


procedure TForm1.f_addClick(Sender: TObject);
begin
  f[n_f] := StrToFloat(f_input.text);

  f_list.Items.Add('f[' + IntToStr(n_f) + '] = ' + f_input.text);

  n_f := n_f + 1;
  f_input.Clear();
end;


procedure TForm1.value_buttonClick(Sender: TObject);
begin
  output_list.Clear();
  st_output.Clear();


  st := 0;
  xx := StrToFloat(xx_input.text);

  res := periodsplinevalue(n - 1, x, f, xx, st);

  output_list.Items.Add('y = ' + FloatToStr(res));                              //tu blad
  st_output.text := IntToStr(st);
end;

procedure TForm1.coeffns_buttonClick(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  output_list.Clear();
  st_output.Clear();

  periodsplinecoeffns(n - 1, x, f, a, st);

  for i := 0 to 3 do
  begin
    for j := 0 to n_f - 2 do
    begin
      output_list.Items.Add('a[' + IntToStr(i) + '][' + IntToStr(j) + '] = ' +
        FloatToStr(a[i][j]));
    end;
  end;

  st_output.text := IntToStr(st);
end;


procedure TForm1.i_x_addClick(Sender: TObject);
begin
  i_n_x := i_n_x + 1;
  i_x[i_n_x - 1].a := StrToFloat(xa_input.text);
  i_x[i_n_x - 1].b := StrToFloat(xb_input.text);

  i_x_list.Items.Add('x[' + IntToStr(i_n_x - 1) + '].a = ' + xa_input.text);
  i_x_list.Items.Add('x[' + IntToStr(i_n_x - 1) + '].b = ' + xb_input.text);

  xa_input.Clear();
  xb_input.Clear();
end;


procedure TForm1.i_f_addClick(Sender: TObject);
begin
  i_n_f := i_n_f + 1;
  i_f[i_n_f - 1].a := StrToFloat(fa_input.text);
  i_f[i_n_f - 1].b := StrToFloat(fb_input.text);

  i_f_list.Items.Add('f[' + IntToStr(i_n_f - 1) + '].a = ' + fa_input.text);
  i_f_list.Items.Add('f[' + IntToStr(i_n_f - 1) + '].b = ' + fb_input.text);

  fa_input.Clear();
  fb_input.Clear();
end;

procedure TForm1.i_value_buttonClick(Sender: TObject);
var
lewy, prawy : String;
begin
  i_output_list.Clear();
  i_st_output.Clear();

  i_xx.a := StrToFloat(xxa_input.text);
  i_xx.b := StrToFloat(xxb_input.text);

  i_result := iperiodsplinevalue(n - 1, i_x, i_f, i_xx, i_st);

  iends_to_strings(i_result, lewy, prawy);

  i_output_list.Items.Add('y = [' + lewy + '] [' + prawy + ']');

//  i_output_list.Items.Add('y = [' + FloatToStr(i_result.a) + '] [' + FloatToStr(i_result.b) + ']');   //tu czasem blad

  i_st_output.text := IntToStr(i_st);

  i_output_list.Items.Add('szerokosc przedzialu = ' + FloatToStr(int_width(i_result)));
end;

procedure TForm1.i_coeffns_buttonClick(Sender: TObject);
var
  i, j        : Integer;
  lewy, prawy : String;
begin
  i_output_list.Clear();
  i_st_output.Clear();

  iperiodsplinecoeffns(n - 1, i_x, i_f, i_a, i_st);

  for i := 0 to 3 do
  begin
    for j := 0 to n - 2 do
    begin
         iends_to_strings(i_a[i][j], lewy, prawy);
         i_output_list.Items.Add('ai[' + IntToStr(i) + '][' + IntToStr(j) + '] = [' +
         lewy + ', ' + prawy + ']');
    end;
  end;

  i_st_output.text := IntToStr(i_st);
end;


procedure TForm1.clear_buttonClick(Sender: TObject);
begin
  n_input.Clear();
  x_input.Clear();
  f_input.Clear();
  f_list.Clear();
  x_list.Clear();
  n_list.Clear();
  xx_input.Clear();
  st_output.Clear();
  output_list.Clear();

  xa_input.Clear();
  xb_input.Clear();
  fa_input.Clear();
  fb_input.Clear();
  xxa_input.Clear();
  xxb_input.Clear();
  i_st_output.Clear();
  i_output_list.Clear();
  i_x_list.Clear();
  i_f_list.Clear();

  FillChar(x, SizeOf(x), 0);
  FillChar(f, SizeOf(f), 0);
  FillChar(a, SizeOf(a), 0);

  xx := 0;
  res := 0;
  st := 0;
  n := 0;
  n_f := 0;
  n_x := 0;
  i_n_f := 0;
  i_n_x := 0;
  i_n := 0;
end;

end.
