from ast import Num
from functools import wraps
from re import S
from traceback import print_tb
from unittest import result
from flask import Flask, g, current_app,render_template, send_from_directory, request, session, redirect, url_for
from flaskext.mysql import MySQL
import os
from werkzeug.utils import secure_filename
from datetime import datetime
#auto-generate password
import string
from random import *
#e-mail
from flask_mail import Mail, Message
import smtplib
from flask_cors import CORS

# Show full processlist;
# kill x;

app = Flask(__name__)

app.secret_key = '56tf645fg6f676hg66'

mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'

app.config['MYSQL_DATABASE_PASSWORD'] = 'root'

app.config['MYSQL_DATABASE_DB'] = 'artgallery'

app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql.init_app(app)


app.config["MAIL_SERVER"]='smtp.gmail.com'  
app.config["MAIL_PORT"] = 465      
app.config["MAIL_USERNAME"] = 'artgallerystpius@gmail.com'  
app.config['MAIL_PASSWORD'] = 'artgallery123'  
app.config['MAIL_USE_TLS'] = False  
app.config['MAIL_USE_SSL'] = True  
mail = Mail(app)  
otp = randint(000000,999999)   

app.config['PATH'] = 'C:/artgallery/server/static/upload'



ALLOWED_EXTENSIONS = {'txt', 'png', 'pdf', 'jpeg', 'jpg', 'gif'}

def allow_for_loggined_users_only(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if 'username' not in session:
            return redirect(url_for('login',next=request.endpoint))
        return f(*args, **kwargs)
    return wrapper

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS




# INDEX PAGE

@app.route('/')
def index():
    return render_template("index.html")


# LOGIN 

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'GET':
        return render_template('login.html')

    if request.method == 'POST':
        conn = mysql.connect()
        curser = conn.cursor()
        query = "select * from login where binary username=%s and binary password=%s"
        curser.execute(
            query, (request.form['username'], request.form['password']))
        conn.commit()
        account = curser.fetchone()
        if account:
            print(account)
            session['loggedin'] = True
            session['lid'] = account[0]
            session['id'] = account[0]

            session['username'] = account[1]
            if account[3] == 'admin':
                return redirect(url_for('admin_home'))
            elif account[3] == 'artist':
       
                return redirect(url_for('artist_home'))
            
            elif account[3] == 'customer':
               
                return redirect(url_for('customer_home'))
        else:
            return 'Please Register'
    else:
        msg = "Incorrect Username or Password"
        return render_template("login.html", msg=msg)
 
# LOGOUT

@app.route('/logout', methods=['GET'])
@allow_for_loggined_users_only
def logout():
    if session['loggedin']:
        session['loggedin'] = False
        session.pop('lid', None)
        session.pop('username', None)
        return redirect(url_for('login'))
    else:
        print("login first")


# ARTIST REGISTRATION

@app.route('/artist_registration', methods=['GET', 'POST'])
def artist_registration():
    if request.method == 'GET':
        return render_template('artist_registration.html')
    if request.method == 'POST':
        data = request.form
        today = datetime.today()
        conn = mysql.connect()
        cursor = conn.cursor()
        email = request.form["email"]   
        msg = Message('OTP',sender = 'artgallerystpius@gmail.com', recipients = [email])  
        msg.body = str(otp)  
        mail.send(msg)  
        query = "insert into login(username,password,type) values (%s,%s,%s)"
        cursor.execute(query, (data['email'], data['password'], 'artist'))
        s=cursor.lastrowid
        conn.commit()
        query = "insert into registration(name,email,phone, adrs,district,city,pin,asso_regno,adhaarno,created_on,lid,type) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(query, (data['name'], data['email'], data['phone'], data['adrs'], data['district'], data['city'], data['pin'], data['asso_regno'], data['adhaarno'], today, cursor.lastrowid, 'artist'))
        conn.commit()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "insert into reg_payment(u_id,date,status,card_holder,csv,exp) values (%s,%s,%s,%s,%s,%s)"
        cursor.execute(query, ( s,today,'paid',data['card_holder'], data['csv'],data['exp']))
        conn.commit()
        conn.close()
        return render_template("verify.html")
        # return redirect(url_for('validate'))


# CUSTOMER REGISTRATION

@app.route('/customer_registration', methods=['GET', 'POST'])
def customer_registration():
    if request.method == 'GET':
        return render_template('customer_registration.html')
    if request.method == 'POST':
        data = request.form
        today = datetime.today()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "insert into login(username,password,type) values (%s,%s,%s)"
        cursor.execute(query, (data['email'], data['password'], 'customer'))
        conn.commit()
        query = "insert into registration(name,email,phone,adrs,district,city,pin,created_on,lid,type) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(query, (data['name'], data['email'], data['phone'], data['adrs'], data['district'], data['city'], data['pin'], today, cursor.lastrowid, 'customer'))
        conn.commit()
        conn.close()
        return redirect(url_for('login'))

# ARTIST NORMAL PRODUCT REGISTRATION

@app.route('/artist_add_product_normal', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def artist_add_product_normal():
    if request.method == 'GET':
        return render_template('artist_add_product_normal.html')
    if request.method == 'POST':
        # try:
        data = request.form

        image = request.files['image']
        if image and allowed_file(image.filename):
            filename = secure_filename(image.filename)
            image.save(os.path.join(app.config['PATH'], filename))
            conn = mysql.connect()
            cursor = conn.cursor()
            s = session['lid']
            path = os.path.join(app.config['PATH'], filename)
            print(path)
            d1 = data['desc']
            query = "INSERT INTO pro_registration(`pname`,`image`,`desc`,`price`,`stock`,`logid`,type) values (%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(query, (data['pname'], filename, d1,data['price'], 1, s,'normal'))
            conn.commit()
            conn.close()
        return redirect(url_for('artist_home'))

# ARTIST HOME

@app.route('/artist_home')
@allow_for_loggined_users_only
def artist_home():
    return render_template("artist_home.html")

# ADMIN HOME

@app.route('/admin_home')
@allow_for_loggined_users_only
def admin_home():
    return render_template("admin_home.html")


# CUSTOMER HOME

@app.route('/customer_home')
@allow_for_loggined_users_only
def customer_home():
    return render_template("customer_home.html")

# CUSTOMER VIEW NORMAL PRODUCT

@app.route('/customer_view_normal_product', methods=['GET'])
@allow_for_loggined_users_only
def customer_view_normal_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select  pro_registration.* ,login.* from pro_registration ,login where login.lid=pro_registration.logid and pro_registration.type='normal' and pro_registration.stock=1"
        cursor.execute(query)
        data = cursor.fetchall()

        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select sum(1) from cart where usr_id=%s "
        cursor.execute(query, (session['lid']))
        # qnty = cursor.fetchall()
        qnty= 1
        return render_template('customer_view_normal_product.html', row=data ,qnty=qnty )


# CUSTOMER VIEW BID OVER PRODUCT

@app.route('/customer_view_bid_over_product', methods=['GET'])
@allow_for_loggined_users_only
def customer_view_bid_over_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query="select pro_registration.* ,registration.*,product_bidding.*,bidding.* from pro_registration ,registration,product_bidding,bidding where registration.lid=bidding.c_id and pro_registration.type='checked' and pro_registration.pid=product_bidding.p_id and product_bidding.pb_id=bidding.b_id and stock='1' and (now() >=product_bidding.end) and registration.lid=%s"
        # query = "select * from pro_registration p,registration r,bidding b,login l,product_bidding where p.type='checked' and p.logid=l.lid and b.c_id=r.lid and p.stock=1 and (now() >=product_bidding.end)"
        cursor.execute(query,(session['lid']))
        data = cursor.fetchall()

        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select sum(1) from cart where usr_id=%s "
        cursor.execute(query, (session['lid']))
        # qnty = cursor.fetchall()
        qnty= 1
        return render_template('customer_view_bid_over_product.html', row=data ,qnty=qnty )

# ADD TO CART

@app.route('/add_to_cart', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def add_to_cart():
    if request.method == 'POST':
        data=request.form
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute('select * from cart where pid=%s and usr_id=%s',(data['pid'],session['lid']))
        dt = cursor.fetchone()
        total=float(1)*float(data['price'])
        if dt is None:
            # insert query
            query = "insert into cart (pid,qnty,total,usr_id) values(%s,%s,%s,%s)"
            cursor.execute(query, (data['pid'], 1, total , session['lid']))
            conn.commit()           
        else:
            qty = float(1)+float(dt[2])
            total = qty*float(data['price'])
            cursor.execute("update cart set qnty=%s,total=%s where pid=%s and usr_id=%s",(qty,total,data['pid'],session['lid']))
            conn.commit()
            print(qty,total)
            print(dt)
            conn.close()
        return redirect(url_for('customer_home'))


    
# CUSTOMER VIEW CART

@app.route('/customer_view_cart', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def customer_view_cart():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = " select * from login , registration, pro_registration ,cart where login.lid=registration.lid and pro_registration.pid=cart.pid and registration.lid=cart.usr_id and registration.lid=%s"
        cursor.execute(query,(session['lid']))
        row = cursor.fetchall()
        conn = mysql.connect()
        cursor = conn.cursor()
        query="select sum(total) from cart where usr_id=%s"
        cursor.execute(query, ( session['lid']))
        sum=cursor.fetchall()
        print(row)
        conn.close()
        return render_template('customer_view_cart.html', row=row, sum=sum)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from cart where crt_id=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
        return redirect(url_for('customer_view_cart'))

# CREATE ORDER 

@app.route('/create_order',methods=['POST'])
@allow_for_loggined_users_only
def create_order():

    if request.method=='POST':
      conn = mysql.connect()
      cursor = conn.cursor()

    cursor.execute("select * from cart where usr_id=%s",session['lid'])
    # data = cursor.fetchall()
    # stock = 0
    # total = 0
    # for item in data:
    #     total+=int(item[3])
    #     print(total)
    #     cursor.execute("select stock from pro_registration where pid=%s",item[1])
    #     dt = cursor.fetchone()
    #     print(dt)
    #     stock = int(dt[0])-int(item[2])
    #     print(stock)
    #     cursor.execute("update pro_registration set stock=%s where pid=%s",(stock,item[1]))
    #     conn.commit()

    # cursor.execute("insert into orders (l_id,total,pay_status,date,order_status) values(%s,%s,%s,%s,%s)",(session['lid'],total,'pending',datetime.now(),'Waiting for updates'))
    # conn.commit()
    

    # session['oid']=cursor.lastrowid
    # session['amnt']=total

    # for sub in data:
    #     cursor.execute("insert into orderitem(pid,oid,qnty,total)values(%s,%s,%s,%s)",(sub[1],cursor.lastrowid,sub[2],sub[3]))
    #     conn.commit()

    # cursor.execute("delete from cart where usr_id=%s",session['lid'])
    conn.commit()

    return redirect(url_for('payment'))


# PAYMENT

@app.route('/payment',methods=['POST','GET'])
@allow_for_loggined_users_only
def payment():
    if request.method=='GET':
        return render_template("payment.html")
    if request.method=='POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from cart where usr_id=%s",session['lid'])
        data = cursor.fetchall()
    stock = 0
    total = 0
    for item in data:
        total+=int(item[3])
        print(total)
        cursor.execute("select stock from pro_registration where pid=%s",item[1])
        dt = cursor.fetchone()
        print(dt)
        stock = int(dt[0])-int(item[2])
        print(stock)
        cursor.execute("update pro_registration set stock=%s where pid=%s",(stock,item[1]))
        conn.commit()

    cursor.execute("insert into orders (l_id,total,pay_status,date,order_status) values(%s,%s,%s,%s,%s)",(session['lid'],total,'pending',datetime.now(),'Waiting for updates'))
    conn.commit()
    

    session['oid']=cursor.lastrowid
    session['amnt']=total

    for sub in data:
        cursor.execute("insert into orderitem(pid,oid,qnty,total)values(%s,%s,%s,%s)",(sub[1],cursor.lastrowid,sub[2],sub[3]))
        conn.commit()
        query = "insert into payment(oid,amount,uid,card_holder_name,card_number,exp,payment_date)values(%s,%s,%s,%s,%s,%s,%s)"
        cursor.execute(query, (
            session['oid'],
            session['amnt'],
            session['lid'],
            request.form['card_holder_name'],
            request.form['card_number'],
            request.form['expiry'],
            datetime.now()
        ))
        conn.commit()
        cursor.execute("select * from cart where usr_id=%s",session['lid'])
    

    cursor.execute("delete from cart where usr_id=%s",session['lid'])
    conn.commit()

    cursor.execute("update orders set pay_status='paid' where oid=%s",session['oid'])
    conn.commit()
    conn.close()

    return redirect(url_for('customer_view_order_item'))

# CUSTOMER VIEW ORDER ITEM

@app.route('/customer_view_order_item')
@allow_for_loggined_users_only
def customer_view_order_item():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select p.pname,p.image,p.price,o.total,o.order_status from orderitem i,orders  o, pro_registration p where i.oid=o.oid and i.pid= p.pid and o.l_id=%s"
        cursor.execute(query,(session['lid']))
        row = cursor.fetchall()
    return render_template("customer_view_order_item.html",row=row)


# ARTIST VIEW PRODUCT ORDER

@app.route('/artist_view_product_order',methods=['GET'])
@allow_for_loggined_users_only
def artist_view_product_order():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query= "SELECT  * from orders o,orderitem i,pro_registration p,registration r where  o.pay_status='paid' and o.order_status='Waiting for updates' and i.oid=o.oid and o.l_id=r.lid and i.pid=p.pid and p.logid=%s"
        cursor.execute(query, session['lid'])
        row = cursor.fetchall()
        conn.close()
        return render_template("artist_view_product_order.html",result=row)

# ARTIST POST PRODUCT TO THE CUSTOMER ADDERESS

@app.route('/posted',methods=['POST','GET'])
@allow_for_loggined_users_only
def posted():
    if request.method=='GET':
        return render_template("artist_view_product_order.html")
    if request.method=='POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("update orders set order_status='posted' where oid=%s",request.form['oid'])
        conn.commit()
        conn.close()

        return redirect(url_for('artist_view_product_order'))

# ARTIST ADD BIDDING PRODUCT

@app.route('/artist_add_product_bidding', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def artist_add_product_bidding():
    if request.method == 'GET':
        return render_template('artist_add_product_bidding.html')
    if request.method == 'POST':
        # try:
        data = request.form
        today = datetime.today()
        image = request.files['image']
        if image and allowed_file(image.filename):
            filename = secure_filename(image.filename)
            image.save(os.path.join(app.config['PATH'], filename))
            conn = mysql.connect()
            cursor = conn.cursor()
            s = session['lid']
            path = os.path.join(app.config['PATH'], filename)
            print(path)
            d1 = data['desc']
            P1=data['price']
            query = "INSERT INTO pro_registration(`pname`,`image`,`desc`,`price`,`stock`,`logid`,type,o_price) values (%s,%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(query, (data['pname'], filename, d1,data['price'], 1, s,'bidding',data['price']))
            session['pid']=cursor.lastrowid
            conn.commit()
            query = "INSERT INTO product_bidding(p_id,start,end) values (%s,%s,%s)"
            cursor.execute(query, (cursor.lastrowid,today,data['end'] ))
            session['end_date']=data['end'] 
            session['pbid']=cursor.lastrowid
            conn.commit()
            query = "INSERT INTO bidding(b_id,bid_status,bid_price,date) values (%s,%s,%s,%s)"
            cursor.execute(query, (cursor.lastrowid,'pending',P1,today))
            # session['prb_id']=cursor.lastrowid
            conn.commit()
            conn.close()
        return render_template('artist_home.html')

########### WORKING CODE START ##############
# # CUSTOMER VIEW BIDDING PRODUCT

# @app.route('/customer_view_bidding_product', methods=['GET','POST'])
# @allow_for_loggined_users_only
# def customer_view_bidding_product():
#     if request.method == 'GET':
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         query = "select pro_registration.* ,registration.*,product_bidding.*,bidding.* from pro_registration ,registration,product_bidding,bidding where registration.lid=pro_registration.logid and pro_registration.type='bidding' and pro_registration.pid=product_bidding.p_id and product_bidding.pb_id=bidding.b_id and stock='1' and (now() <=product_bidding.end)"
#         cursor.execute(query)
#         data = cursor.fetchall()
# #  select ( now() >=product_bidding.end) as biddate from product_bidding;
#         conn.close()
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         query = "select sum(1) from cart where usr_id=%s "
#         cursor.execute(query, (session['lid']))
#         # qnty = cursor.fetchall()
#         qnty= 1
#         return render_template('customer_view_bidding_product.html', row=data ,qnty=qnty )
#     if request.method == 'POST':
#         data=request.form
#         today = datetime.today()
#         pb=data['bid_price']
#         # conn = mysql.connect()
#         # cursor = conn.cursor()
#         # bid_amount= "select bid_price from bidding"
#         # cursor.execute()
#         # conn.commit()
#         print(pb)
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         cursor.execute("update bidding b,product_bidding prb,pro_registration pr set b.bid_price=%s,b.bid_status='running',b.date=%s,b.c_id=%s WHERE pr.pid=prb.p_id and prb.pb_id=b.b_id and b.bid_price<=%s",(pb,today,session['lid'],pb)) 
#         conn.commit()
#         conn.close()         
#         return redirect(url_for('customer_home'))
#########END ###########

# CUSTOMER VIEW BIDDING PRODUCT

@app.route('/customer_view_bidding_product', methods=['GET','POST'])
@allow_for_loggined_users_only
def customer_view_bidding_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select pro_registration.* ,registration.*,product_bidding.*,bidding.* from pro_registration ,registration,product_bidding,bidding where registration.lid=pro_registration.logid and pro_registration.type='bidding' and pro_registration.pid=product_bidding.p_id and product_bidding.pb_id=bidding.b_id and stock='1' and (now() <=product_bidding.end)"
        cursor.execute(query)
        data = cursor.fetchall()
#  select ( now() >=product_bidding.end) as biddate from product_bidding;
        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select sum(1) from cart where usr_id=%s "
        cursor.execute(query, (session['lid']))
        # qnty = cursor.fetchall()
        qnty= 1
        return render_template('customer_view_bidding_product.html', row=data ,qnty=qnty )
    if request.method == 'POST':
        data=request.form
        today = datetime.today()
        pb=data['bid_price']
        pr=data['pid']
        # conn = mysql.connect()
        # cursor = conn.cursor()
        # bid_amount= "select bid_price from bidding"
        # cursor.execute()
        # conn.commit()
        print(pb)
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("update bidding b,product_bidding prb,pro_registration pr set pr.price=%s,b.bid_price=%s,b.bid_status='running',b.date=%s,b.c_id=%s WHERE pr.pid=prb.p_id and prb.pb_id=b.b_id and b.bid_price<%s",(pb,pb,today,session['lid'],pb)) 
        conn.commit()
       
        conn.close()         
        return redirect(url_for('customer_home'))


# CUSTOMER VIEW BIDDING PRODUCT

# @app.route('/customer_view_bidding_product', methods=['GET','POST'])
# @allow_for_loggined_users_only
# def customer_view_bidding_product():
#     if request.method == 'GET':
#         data=request.form
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         query = "select pro_registration.* ,registration.*,product_bidding.* from pro_registration ,registration,product_bidding where registration.lid=pro_registration.logid and pro_registration.type='bidding' and pro_registration.pid=product_bidding.p_id and stock='1'"
#         cursor.execute(query)
#         data = cursor.fetchall()

#         conn.close()
#         bp=1111
#         today = datetime.today()
#         # pb=data['bid_price']
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         bid_amount= "select bid_price from bidding,product_bidding where product_bidding.pb_id=bidding.b_id and bidding.b_id=%s"
#         cursor.execute(bid_amount,(request.form.get('pid')))
#         conn.commit()
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         bt= "select (now() >=product_bidding.end) from product_bidding where pb_id=%s"
#         cursor.execute(bt,(request.form.get('pid')))
#         data = cursor.fetchone(bt)

#         conn.commit()
#         print(data)
#         conn = mysql.connect()
#         cursor = conn.cursor()
#         query = "select sum(1) from cart where usr_id=%s "
#         cursor.execute(query, (session['lid']))
#         # qnty = cursor.fetchall()
#         qnty= 1
#         return render_template('customer_view_bidding_product.html', row=data ,qnty=qnty )
#     if request.method == 'POST':
#         data=request.form
#         # bp=request.form['bid_price']
#         # today = datetime.today()
#         # pb=data['bid_price']
#         # conn = mysql.connect()
#         # cursor = conn.cursor()
#         # bid_amount= "select bid_price from bidding,product_bidding where product_bidding.pb_id=bidding.b_id and bidding.b_id=%s"
#         # cursor.execute(bid_amount,request.form.get('pid'))
#         # conn.commit()
#         # conn = mysql.connect()
#         # cursor = conn.cursor()
#         # bt= "select (now() >=product_bidding.end) from product_bidding where pb_id=%s"
#         # cursor.execute(bt,request.form.get('pid'))
#         # data = cursor.fetchone(bt)

#         # conn.commit()
#         # print(data)

       
#         if( bid_amount<bp):
#             conn = mysql.connect()
#             cursor = conn.cursor()
#             cursor.execute("update bidding b,product_bidding prb,pro_registration pr set b.bid_price=%s,b.bid_status='running',b.date=%s WHERE pr.pid=prb.p_id and prb.pb_id=b.b_id and b.c_id=%s",(pb,today,session['lid'])) 
#             conn.commit()
#             conn.close()         
#             return redirect(url_for('customer_home',result=data))

#         elif(data==1):
#             conn = mysql.connect()
#             cursor = conn.cursor()
#             cursor.execute("update bidding b,product_bidding prb,pro_registration pr set b.bid_price=%s,b.bid_status='bidover',b.date=%s WHERE pr.pid=prb.p_id and prb.pb_id=b.b_id and b.c_id=%s",(pb,today,session['lid'])) 
#             conn.commit()
#             conn.close()   
#             return redirect(url_for('customer_view_bid_over_product')) 
#         else:
#             msg = "Enter Valid Amount"
#             return render_template("customer_view_bidding_product.html", msg=msg)     
#     return redirect(url_for('customer_home',result=data))
 



# ADMIN VIEW NORMAL PRODUCT

@app.route('/admin_view_normal_product', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def admin_view_normal_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from pro_registration where type='normal'and stock=1"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
        return render_template('admin_view_normal_product.html', result=data)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from pro_registration where pid=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from pro_registration where type='normal'"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
        return render_template('admin_view_normal_product.html', result=data)

# ADMIN VIEW bidding PRODUCT  

@app.route('/admin_view_bidding_product', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def admin_view_bidding_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from pro_registration where type='bidding' and stock='1'"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
        return render_template('admin_view_bidding_product.html', result=data)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from pro_registration where pid=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from pro_registration where type='bidding' and stock='1'"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
        return render_template('admin_view_bidding_product.html', result=data)


# ADMIN VIEW BID OVER PRODUCT  

@app.route('/admin_view_bid_over_product', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def admin_view_bid_over_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select pro_registration.* ,registration.*,product_bidding.*,bidding.* from pro_registration ,registration,product_bidding,bidding where registration.lid=bidding.c_id and pro_registration.type='bidding' and pro_registration.pid=product_bidding.p_id and product_bidding.pb_id=bidding.b_id and stock='1' and (now() >=product_bidding.end)"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
        return render_template('admin_view_bid_over_product.html', result=data)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("update pro_registration set type='checked' where pid=%s",request.form.get('pid'))
        data=cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('admin_view_bid_over_product.html', result=data)


 # ADMIN ADD NOTIFICATION

@app.route('/admin_add_notification', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def admin_add_notification():
    if request.method == 'GET':
        return render_template('admin_add_notification.html')
    if request.method == 'POST':
        data = request.form
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "insert into notification(subject,content,date) values(%s,%s,%s)"
        cursor.execute(query, (data['subject'], data['content'],datetime.now()))
        conn.commit()
        conn.close()
        return render_template('admin_home.html')

# ADMIN VIEW NOTIFICATION

@app.route('/admin_view_notification', methods=['GET','POST'])
@allow_for_loggined_users_only
def admin_view_notification():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from notification")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('admin_view_notification.html', result=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from notification where id=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
        return redirect(url_for('admin_view_notification'))

# ARTIST VIEW NOTIFICATION

@app.route('/artist_view_notification', methods=['GET','POST'])
@allow_for_loggined_users_only
def artist_view_notification():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from notification")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
    return render_template('artist_view_notification.html', result=row)


# ARTIST VIEW ARTIST

@app.route('/admin_view_artist', methods=['GET','POST'])
@allow_for_loggined_users_only
def admin_view_artist():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from registration where type='artist'")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('admin_view_artist.html', result=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from registration where lid=%s"
        query= "delete from login where lid=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from registration where type='artist'"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
    return redirect(url_for('admin_view_artist'))

# ARTIST VIEW NORMAL PRODUCT

@app.route('/artist_view_normal_product', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def artist_view_normal_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from pro_registration,login where  stock=1 and login.lid=%s and pro_registration.type='normal'"
        cursor.execute(query,(session['lid']))
        data = cursor.fetchall()
        conn.commit()
        conn.close()
    return render_template('artist_view_normal_product.html', result=data)


# ARTIST VIEW BID PRODUCT

@app.route('/artist_view_bid_product', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def artist_view_bid_product():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from pro_registration,login where  stock=1 and login.lid=%s and pro_registration.type='bidding';"
        cursor.execute(query,(session['lid']))
        data = cursor.fetchall()
        conn.commit()
        conn.close()
    return render_template('artist_view_bid_product.html', result=data)


# ARTIST VIEW CUSTOMER

@app.route('/admin_view_customer', methods=['GET','POST'])
@allow_for_loggined_users_only
def admin_view_customer():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from registration where type='customer'")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('admin_view_customer.html', result=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from registration where lid=%s"
        query= "delete from login where lid=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "select * from registration where type='customer'"
        cursor.execute(query)
        data = cursor.fetchall()
        conn.close()
    return redirect(url_for('admin_view_customer'))


# CUSTOMER VIEW NOTIFICATION

@app.route('/customer_view_notification', methods=['GET','POST'])
@allow_for_loggined_users_only
def customer_view_notification():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from notification")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
    return render_template('customer_view_notification.html', result=row)


# CUSTOMER ADD FEEDBACK



@app.route('/feedback', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def feedback():
    if request.method == 'GET':
        return render_template('customer_add_feedback.html')
    if request.method == 'POST':
        data = request.form
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "insert into feedback(lid,subject,feedback,created_on) values(%s,%s,%s,%s)"
        cursor.execute(query, (session['lid'],data['subject'], data['feedback'],datetime.now()))
        conn.commit()
        conn.close()
        return render_template('customer_home.html')

# ADMIN VIEW FEEDBACK


@app.route('/admin_view_feedback', methods=['GET','POST'])
@allow_for_loggined_users_only
def admin_view_feedback():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from feedback")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('admin_view_feedback.html', result=row)
    if request.method == 'POST':
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "delete from feedback where fid=%s"
        cursor.execute(query, request.form.get('delete_by_id'))
        conn.commit()
        conn.close()
    return redirect(url_for('admin_view_feedback'))

# ARTIST VIEW FEEDBACK


@app.route('/artist_view_feedback', methods=['GET','POST'])
@allow_for_loggined_users_only
def artist_view_feedback():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select subject,feedback,created_on from feedback,payment where payment.uid=feedback.lid")
        row = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('artist_view_feedback.html', result=row)

# CUSTOMER ADD COMPLAINT       
   
@app.route('/customer_add_complaints', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def customer_add_complaints():
    if request.method == 'GET':
        return render_template('customer_add_complaint.html')
    if request.method == 'POST':
        data = request.form
        print(session['lid'])
        conn = mysql.connect()
        cursor = conn.cursor()
        query = "insert into complaint (complaint,lid,complaint_date) values (%s,%s,%s)"
        cursor.execute(query, (data['complaint'],
                       session['lid'], datetime.now()))
        print(query)
        conn.commit()
        conn.close()
        return render_template('customer_home.html')

# ADMIN REPLAY TO COMPLAIMNTS

@app.route('/admin_reply_complaints', methods=['GET', 'POST'])
@allow_for_loggined_users_only
def admin_reply_complaints():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from complaint")
        row = cursor.fetchall()
        print(row)
        conn.commit()
        conn.close()
        return render_template('admin_reply_complaints.html', result=row)
    if request.method == 'POST':
        if request.json is not None:
            print(request.json)
            data = request.json
            print(datetime.now())
            conn =mysql.connect()
            cursor = conn.cursor()
            q=" UPDATE complaint SET reply ='{}',reply_date ='{}' WHERE cmp_id='{}'"
            query= q.format(data['reply'], datetime.now(),data['cmp_id'])                    
            print(query)
            cursor.execute(query)
            conn.commit()
            conn.close()
            return redirect(url_for('admin_reply_complaints'))
        else:
            return redirect(url_for('admin_reply_complaints'))


# @app.route('/verify',methods = ["POST"])  
# def verify():  
#     email = request.form["email"]   
#     msg = Message('OTP',sender = 'avmaneesha@gmail.com', recipients = [email])  
#     msg.body = str(otp)  
#     mail.send(msg)  
#     return render_template('verify.html')  

# OTP VALIDATION

@app.route('/validate',methods=['POST','GET'])   
def validate():  
    user_otp = request.form['otp']  
    if otp == int(user_otp):
        return redirect(url_for('login'))  
    return "<h3>failure, OTP does not match</h3>" 

# CUSTOMER VIEW COMPLAINT REPLAY

@app.route('/customer_view_complaint_reply', methods=['GET'])
@allow_for_loggined_users_only
def customer_view_complaint_reply():
    if request.method == 'GET':
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("select * from complaint where lid=%s",session['lid'])
        row = cursor.fetchall()
        conn.commit()
        conn.close()
        return render_template('customer_view_complaint_reply.html', result=row)


if __name__ == '__main__':
    app.run(debug=True,host="localhost",port=4000)
