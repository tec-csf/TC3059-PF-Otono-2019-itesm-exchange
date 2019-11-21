#!/usr/bin/env python
import os
import datetime
from datetime import date, timedelta
from flask import Flask, abort, request, jsonify, g, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import func, and_, or_, not_
from flask_httpauth import HTTPBasicAuth
from passlib.apps import custom_app_context as pwd_context
from itsdangerous import (TimedJSONWebSignatureSerializer
                          as Serializer, BadSignature, SignatureExpired)
from flask_mysqldb import MySQL
import mysql.connector
from mysql.connector import Error
from mysql.connector import errorcode
from flask_marshmallow import Marshmallow
from dateutil.relativedelta import relativedelta
from decimal import getcontext, Decimal
import numpy as np
import json
import smtplib, ssl
import requests
import http.client
import base64
from flask_cors import CORS
import logging
from flask import Flask, render_template, request, Response
import sqlalchemy
# Remember - storing secrets in plaintext is potentially unsafe. Consider using
# something like https://cloud.google.com/kms/ to help keep secrets secret.
#db_user = os.environ.get("kaleb")
#db_pass = os.environ.get("kaleb")
#db_name = os.environ.get("itesm_exchange")
#cloud_sql_connection_name = os.environ.get("itesm-exchange:us-central1:backend")

app = Flask(__name__)
CORS(app)

logger = logging.getLogger()

# Initialization:
# [START cloud_sql_mysql_sqlalchemy_create]
# The SQLAlchemy engine will help manage interactions, including automatically
# managing a pool of connections to your database
#db = sqlalchemy.create_engine(
#    sqlalchemy.engine.url.URL(
#        drivername='mysql+pymysql',
#        username = db_user,
#        password = db_pass,
#        database = db_name,
#        query = {
#            'unix_socket': '/cloudsql/{}'.format(cloud_sql_connection_name)
#        }
#    ),
#)

app.config['SECRET_KEY'] = 'Kalen tiene cara de pitoscuro'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://kaleb:kaleb@35.239.222.150:3306/itesm_exchange'
app.config['SQLALCHEMY_COMMIT_ON_TEARDOWN'] = True
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# extensions
db = SQLAlchemy(app)
auth = HTTPBasicAuth()
ma = Marshmallow(app)
url = "http://localhost:5000"
_url = 'http://localhost:5000'

############################################################################################################################################################################################################
## Users


class User(db.Model):
    __tablename__ = 'users'
    username = db.Column(db.String(50), primary_key=True)
    userid = db.Column(db.String(9), default='A00XXXXXX')
    password = db.Column(db.String(512))
    name = db.Column(db.String(50))
    last_name = db.Column(db.String(50))
    created = db.Column(db.DateTime, default=datetime.datetime.utcnow)
    id_user_type = db.Column(db.Integer)
    id_campus = db.Column(db.Integer, default="1")

    def hash_password(self, password):
        self.password = pwd_context.encrypt(password)

    def verify_password(self, password):
        return pwd_context.verify(password, self.password)

    def generate_auth_token(self, expiration=600):
        s = Serializer(app.config['SECRET_KEY'], expires_in=expiration)
        return s.dumps({'username': self.username})

    @staticmethod
    def verify_auth_token(token):
        s = Serializer(app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except SignatureExpired:
            return None    # valid token, but expired
        except BadSignature:
            return None    # invalid token
        user = User.query.get(data['username'])
        return user


@auth.verify_password
def verify_password(username_or_token, password):
    # first try to authenticate by token
    user = User.verify_auth_token(username_or_token)
    if not user:
        # try to authenticate with username/password
        user = User.query.filter_by(username=username_or_token).first()
        if not user or not user.verify_password(password):
            return False
    g.user = user
    return True


@app.route('/api/users', methods=['POST'])
def new_user():
    username = request.json.get('username')
    userid = request.json.get('userid')
    password = request.json.get('password')
    name = request.json.get('name')
    last_name = request.json.get('last_name')
    created = request.json.get('created')
    id_user_type = request.json.get('id_user_type')
    id_campus = request.json.get('id_campus')
    if username is None or password is None or name is None or last_name is None or created is None or id_user_type is None:
        abort(400)    # missing arguments
    if User.query.filter_by(username=username).first() is not None:
        #abort(401)    # existing user
        alredy = 'Usuario ya existe'
        return (jsonify({'username': username,'estado': alredy}), 401)
        #abort(401)
    user = User(username=username,userid=userid,name=name,last_name=last_name,created=created,id_user_type=id_user_type,id_campus=id_campus)
    user.hash_password(password)
    ##print(user)
    db.session.add(user)
    db.session.commit()
    return (jsonify({'username': user.username}), 201,
            {'Location': url_for('get_user', username=user.username, _external=True)})


@app.route('/api/users/<string:username>')
def get_user(username):
    user = User.query.get(username)
    if not user:
        abort(400)
    return jsonify({'username': user.username})

@app.route('/api/token')
@auth.login_required
def get_auth_token():
    token = g.user.generate_auth_token(600)
    return jsonify({'token': token.decode('ascii'), 'duration': 600, 'id_user_type': g.user.id_user_type})

# Get name by username:
@app.route('/api/users/name', methods=['POST'])
@auth.login_required
def get_name():
    username = request.json.get('username')
    if username is None:
        respuesta = 'No user found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    thisName = Campus.query.filter_by(username=username).first()
    result = grades_schema.dump(thisName)
    return jsonify(result)   # existing account number

############################################################################################################################################################################################################
## Cuentas

class Campus(db.Model):
    __tablename__ = 'campus'
    id_campus = db.Column(db.Integer, primary_key=True)
    campus_name = db.Column(db.String(100))
    created = db.Column(db.DateTime, default=datetime.datetime.utcnow)

def __init__(self,id_campus,campus_name,created):
        self.id_campus = id_campus
        self.campus_name = campus_name
        self.created = created

#Schema TipoMovimientos
class SchemaCampus(ma.Schema):
    class Meta:
        fields = ('id_campus','campus_name','created')

#Init Schema
campus_schema = SchemaCampus()
campuss_schema = SchemaCampus(many=True)

#INSERTAR EN CAMPUS
@app.route('/api/campus', methods=['POST'])
@auth.login_required
def new_campus():
    id_campus = None
    campus_name= request.json.get('campus_name')
    created = request.json.get('created')
    if campus_name is None or created is None:
        respuesta = 'No campus found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    campus = Campus(id_campus=id_campus,campus_name=campus_name,created=created)
    db.session.add(campus)
    db.session.commit()
    return (jsonify({'id_campus': campus.id_campus, 'campus_name':campus.campus_name}), 201
            #,{'Location': url_for('get_account', idCuentaMovimiento=movimiento.idCuentaMovimiento, _external=True)}
            )

#BUSQUEDA DE CAMPUS
@app.route('/api/campus/id', methods=['POST'])
@auth.login_required
def get_campus():
    id_campus = request.json.get('id_campus')
    if id_campus is None:
        respuesta = 'No id found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    campus = Campus.query.filter_by(id_campus=id_campus).first()
    result = campus_schema.dump(campus)
    return jsonify(result)   # existing account number


#BUSQUEDA DE CAMPUS
@app.route('/api/campus', methods=['GET'])
@auth.login_required
def get_campuss():
    campus = Campus.query.all()
    result = campuss_schema.dump(campus)
    return jsonify(result)   # existing account number

############################################################################################################################################################################################################
## Grades

class Grades(db.Model):
    __tablename__ = 'grades'
    id = db.Column(db.Integer, primary_key=True)
    id_course = db.Column(db.Integer)
    student = db.Column(db.String(50))
    professor = db.Column(db.String(50))
    grade = db.Column(db.Integer)
    created = db.Column(db.DateTime, default=datetime.datetime.utcnow)

def __init__(self,id,id_course,student,professor,grade,created):
        self.id = id
        self.id_course = id_course
        self.student = student
        self.professor = professor
        self.grade = grade
        self.created = created

#Schema TipoMovimientos
class SchemaGrade(ma.Schema):
    class Meta:
        fields = ('id','id_course','student','professor','grade','created')

#Init Schema
grade_schema = SchemaGrade()
grades_schema = SchemaGrade(many=True)

#INSERTA CALIFICACION
@app.route('/api/grade', methods=['POST'])
@auth.login_required
def new_grade():
    id = None
    id_course = request.json.get('id_course')
    student = request.json.get('student')
    professor = request.json.get('professor')
    grade = request.json.get('grade')
    created = request.json.get('created')
    if id_course is None or student is None or professor is None or grade is None:
        respuesta = 'No correct grade found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    grade = Grades(id=id,id_course=id_course,student=student,professor=professor,grade=grade,created=created)
    db.session.add(grade)
    db.session.commit()
    return (jsonify({'id_course': grade.id_course, 'student':grade.student, 'professor': grade.professor}), 201
            #,{'Location': url_for('get_account', idCuentaMovimiento=movimiento.idCuentaMovimiento, _external=True)}
            )

#BUSQUEDA DE CALIFICACION
@app.route('/api/grade/professor', methods=['POST'])
@auth.login_required
def get_gprof():
    professor = request.json.get('professor')
    if professor is None:
        respuesta = 'No professor found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    grades = Grades.query.filter_by(professor=professor).all()
    result = grades_schema.dump(grades)
    return jsonify(result)   # existing account number


#BUSQUEDA DE CALIFICACION
@app.route('/api/grade/student', methods=['POST'])
@auth.login_required
def get_gstu():
    student = request.json.get('student')
    if student is None:
        respuesta = 'No professor found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    grades = Grades.query.filter_by(student=student).all()
    result = grades_schema.dump(grades)
    return jsonify(result)   # existing account number

# Update Grade:
@app.route('/api/grade/update', methods=['PUT'])
@auth.login_required
def update_grade():
    id = request.json.get('id')
    new_grade = request.json.get('new_grade')
    if id is None:
        respuesta = 'No grade found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    else:
        last_grade = Grades.query.filter_by(id=id).first()
        last_grade.grade = new_grade
        db.session.commit()
        return jsonify(last_grade)   # existing account number

############################################################################################################################################################################################################
#CURSOS:

class Course(db.Model):
    __tablename__ = 'courses'
    id_course = db.Column(db.Integer, primary_key=True)
    course_description = db.Column(db.String(100))
    first_day = db.Column(db.DateTime)
    last_day = db.Column(db.DateTime)
    created = db.Column(db.DateTime, default=datetime.datetime.utcnow)

def __init__(self, id_course, course_description,first_day, last_day, created):
        self.id_course = id_course
        self.course_description = course_description
        self.first_day = first_day
        self.last_day = last_day
        self.created = created

#Schema TipoMovimientos
class SchemaCourse(ma.Schema):
    class Meta:
        fields = ('id_course', 'course_description', 'first_day', 'last_day', 'created')

#Init Schema
course_schema = SchemaCourse()
courses_schema = SchemaCourse(many=True)

#INSERTAR EN CURSO
@app.route('/api/course', methods=['POST'])
@auth.login_required
def new_course():
    id_course = None
    course_description = request.json.get('course_description')
    first_day = request.json.get('first_day')
    last_day = request.json.get('last_day')
    created = request.json.get('created')
    if course_description is None:
        respuesta = 'No course found'
        return (jsonify({'response': respuesta}), 400)    # missing arguments
    course = Course(id_course=id_course, course_description=course_description, first_day=first_day, last_day=last_day, created=created)
    db.session.add(course)
    db.session.commit()
    return (jsonify({'id_course': course.id_course, 'course_description': course.course_description, 'first_day': course.first_day, 'last_day': course.last_day}), 201
            #,{'Location': url_for('get_account', idCuentaMovimiento=movimiento.idCuentaMovimiento, _external=True)}
            )

#BUSQUEDA DE CURSO
@app.route('/api/course', methods=['GET'])
@auth.login_required
def get_courses():
    course = Course.query.all()
    result = courses_schema.dump(course)
    return jsonify(result)   # existing account number

#################################################################
#TIPOS DE USUARIO:

class UserType(db.Model):
    __tablename__ = 'user_type'
    id_user_type = db.Column(db.Integer, primary_key=True)
    description_user_type = db.Column(db.String(100))
    created = db.Column(db.DateTime, default=datetime.datetime.utcnow)

def __init__(self,id_user_type, description_user_type, created):
        self.id_user_type = id_user_type
        self.description_user_type = description_user_type
        self.created = created

#Schema TipoMovimientos
class SchemaUserType(ma.Schema):
    class Meta:
        fields = ('id_user_type', 'description_user_type', 'created')

#Init Schema
user_type_schema = SchemaUserType()
users_type_schema = SchemaUserType(many=True)

#BUSQUEDA DE TIPO DE USUARIO
@app.route('/api/user_type', methods=['GET'])
@auth.login_required
def get_user_type():
    user_type = UserType.query.all()
    result = users_type_schema.dump(user_type)
    return jsonify(result)   # existing account number

############################################################################################################################################################################################################

@app.route('/')
def hello():
    return "Hello World!"

if __name__ == '__main__':
    #cur = dmaxo.cursor()
    #to_filter = []
    #to_filter.append('detualdo')
    #cursor = cur.execute(
    #        "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = %s",
    #        to_filter
    #    )
    #row_count= cursor.rowcount
    #if row_count==0:
    #    db.create_all()
    #app.run(debug=True)
    #db.create_all()
    app.run(host='0.0.0.0')
    app.run(debug=True)
    app.run(ssl_context='adhoc')
