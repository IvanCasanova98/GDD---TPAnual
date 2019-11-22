﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using FrbaOfertas.Modelo;
using System.Globalization;
using FrbaOfertas.BaseDeDatos;

namespace FrbaOfertas.ConectorDB
{
    class FuncionesCliente
    {
        public static void altaCliente(Cliente cliente)
        {
            if (string.IsNullOrEmpty(cliente.monto)) cliente.monto = "200";
            
            
            SqlConnection connection = new SqlConnection(Conexion.getStringConnection());
            SqlCommand comm = connection.CreateCommand();
            comm.CommandText = "INSERT INTO HPBC.Cliente (clie_nombre, clie_apellido, clie_dni, clie_mail, clie_tel, clie_calle, clie_piso, clie_dpto , clie_fecha_nac,  clie_localidad, clie_habilitado, clie_monto, clie_usuario_ID) " +
                                "VALUES ('" + cliente.nombre + "', '" + cliente.apellido + "', " + cliente.documento + ", '" + cliente.mail + "'," +
                                " " + cliente.telefono + ",'" + cliente.Calle + "', " + cliente.Piso + ",'" + cliente.Dpto + "', '" + cliente.fecha_nacimiento.ToString("yyyy-MM-dd") + "' , '" + cliente.Localidad + "', " + Convert.ToInt32(cliente.habilitado) + ", " + cliente.monto + ",  (SELECT usuario_id from HPBC.Usuario where usuario_id not in (SELECT ID_Usuario from HPBC.Rol_Por_Usuario)))";               
            comm.Connection = connection;
            comm.Connection.Open();
            comm.ExecuteNonQuery();
            comm.Connection.Close();
            connection.Close();
        }
        public static Cliente traerCliente(int id) {
            Cliente clienteBuscado = new Cliente();
            SqlConnection connection = new SqlConnection(Conexion.getStringConnection());
            SqlCommand comm = connection.CreateCommand();
            comm.CommandText = "SELECT DISTINCT clie_ID, clie_nombre, clie_apellido, clie_dni, clie_mail, clie_tel, clie_fecha_nac, clie_calle, clie_piso, clie_dpto, clie_localidad, clie_monto, clie_habilitado " +
                                "FROM HPBC.Cliente  WHERE clie_ID = "+ id ;
            comm.Connection = connection;
            comm.Connection.Open();
            SqlDataReader reader = comm.ExecuteReader() as SqlDataReader;
            while (reader.Read())
            {
                clienteBuscado.nombre = reader["clie_nombre"].ToString();
                clienteBuscado.apellido = reader["clie_apellido"].ToString();
                clienteBuscado.documento = reader["clie_dni"].ToString();
                clienteBuscado.mail = reader["clie_mail"].ToString();
                clienteBuscado.telefono = reader["clie_tel"].ToString();
                clienteBuscado.fecha_nacimiento = Convert.ToDateTime(reader["clie_fecha_nac"]);
                clienteBuscado.Calle = reader["clie_calle"].ToString();
                clienteBuscado.Piso = reader["clie_piso"].ToString();
                clienteBuscado.Dpto = reader["clie_dpto"].ToString();
                clienteBuscado.Localidad = reader["clie_localidad"].ToString();
                clienteBuscado.monto = reader["clie_monto"].ToString();
                clienteBuscado.habilitado = Convert.ToBoolean(reader["clie_habilitado"].ToString());
            }

            clienteBuscado.id = id;
            connection.Close();
            return clienteBuscado;
        }


        public static Boolean existeDNI(string dni)
        {
           return FrbaOfertas.ConectorDB.FuncionesGlobales.existeTabla(dni, "DNI");

        }

        public static Boolean existeMail(string mail)
        {
            return FrbaOfertas.ConectorDB.FuncionesGlobales.existeTabla(mail, "Email");

        }


        public static void BajaLogicaCliente(int id) {

            FrbaOfertas.ConectorDB.FuncionesGlobales.BajaLogica(id, "Cliente");
        }
        public static void UpdateCliente(Cliente cliente)
        {

            SqlConnection connection = new SqlConnection(Conexion.getStringConnection());
            SqlCommand comm = connection.CreateCommand();
            comm.CommandText = "UPDATE HPBC.Cliente SET clie_nombre = '" + cliente.nombre + "', clie_apellido= '" + cliente.apellido + "', clie_dni= " + cliente.documento + ", clie_mail= '" + cliente.mail + "' , clie_tel= " + cliente.telefono + ", clie_calle= '" + cliente.Calle + "', clie_piso= " + cliente.Piso + ", clie_dpto = '" + cliente.Dpto + "' , clie_fecha_nac = '" + cliente.fecha_nacimiento.ToString("yyyy-MM-dd") + "' ,  clie_localidad = '" + cliente.Localidad + "', clie_habilitado = " + Convert.ToInt32(cliente.habilitado) + ", clie_monto= " + cliente.monto +
                               " WHERE clie_ID = " + cliente.id;
            comm.Connection = connection;
            comm.Connection.Open();
            comm.ExecuteNonQuery();
            comm.Connection.Close();
            connection.Close();
        }

    }
}
