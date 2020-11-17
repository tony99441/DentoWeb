﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using DentoWebMVC.Models.Context;
using DentoWebMVC.Models.DentoWeb;
using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.CSharp.Syntax;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace DentoWebMVC.Controllers
{
    public class ClienteController : Controller
    {

        public DentoWebContext cnx;
        public readonly IConfiguration configuration;
        public ClienteController(DentoWebContext cnx, IConfiguration configuration)
        {
            this.configuration = configuration;
            this.cnx = cnx;
        }

        public IActionResult Index()
        {
            var claim = HttpContext.User.Claims.FirstOrDefault();
            var user = cnx.Clientes.Where(o => o.usuario == claim.Value).First();
            ViewBag.Claim = claim;
            ViewBag.User = user;

            var estado = cnx.Citas.Where(o => o.idCita == user.idCliente).FirstOrDefault();
            ViewBag.Estado = estado;

            var citascliente = cnx.Citas.Where(o => o.idCliente == user.idCliente).FirstOrDefault();

            if (citascliente != null)
            {
                ViewBag.Citas = cnx.Citas.Include(o => o.horario).Include(o => o.doctor).Where(o => o.idCliente == user.idCliente).ToList();
            }
            else
            {
                TempData["CitasNull"] = "Usted no tienes citas pendientes...";
            }


            return View();
        }
        [HttpGet]
        public ActionResult CreateCita (){
            ViewBag.Horarios = cnx.Horarios.ToList();
            ViewBag.Doctors = cnx.Doctors.ToList();
            return View();
        }

        [HttpPost]
        public ActionResult CreateCita(string idhorario, int iddoctor, DateTime fecha)
        {
            var horariodoctor = cnx.Citas.Include(o => o.horario).Where(o => o.idDoctor == Convert.ToInt32(iddoctor)).ToList();
            var horarios = cnx.Horarios.ToList();
            bool estado = false;
            foreach (var item in horariodoctor)
            {
                if (item.fecha == fecha)
                {
                    if (item.idHorario == Convert.ToInt32(idhorario))
                    {
                        estado = false;
                        TempData["CitaNoCreada"] = "Horario Ocupado";
                        break;
                    }
                    else
                    {
                        estado = true;
                    }
                }
                else
                {
                    if (DateTime.Now < fecha)
                    {
                        estado = true;
                    }
                    else
                    {
                        estado = false;
                        TempData["CitaNoCreada"] = "Fecha invalida";
                    }
                }
            }

            if (estado)
            {
                var claim = HttpContext.User.Claims.FirstOrDefault();
                var user = cnx.Clientes.Where(o => o.usuario == claim.Value).First();

                Cita cita = new Cita();

                cita.fecha = fecha;

                cita.idHorario = Convert.ToInt32(idhorario);

                cita.estado = "PENDIENTE";

                cita.idCliente = user.idCliente;

                cita.idDoctor = Convert.ToInt32(iddoctor);

                cita.monto = Convert.ToDecimal(0.0);

                cnx.Citas.Add(cita);
                cnx.SaveChanges();
                TempData["CitaCreada"] = "Cita creada con exito";
            }


            return RedirectToAction("Index","Cliente");
        }


        public ActionResult CancelarCita(int id)
        {
            var cita = cnx.Citas.Where(o => o.idCita == id).FirstOrDefault();

            cita.estado = "CANCELADA";

            cnx.SaveChanges();


            return RedirectToAction("Index","Cliente");
        }

        [HttpGet]
        public ActionResult CreateCliente()
        {
            return View("CreateCliente");
        }


        [HttpPost]
        public ActionResult CreateCliente(Cliente cliente)
        {
            if (!ModelState.IsValid)
            {

                return View();

            }

            cliente.codigo = "C - " + cliente.usuario;
            
            var pass = CreateHash(cliente.passwd);
            cliente.passwd = pass;
            cnx.Clientes.Add(cliente);
            cnx.SaveChanges();

            return RedirectToAction("Login", "Auth");


        }

        public ActionResult DetalleCitaPaciente(int id)
        {
            var historia = cnx.Historias.Include(o => o.cita).Where(o => o.idCita == id).FirstOrDefault();
            var paciente = cnx.Clientes.Where(o => o.idCliente == historia.cita.idCliente).FirstOrDefault();
            var doctor = cnx.Doctors.Where(o => o.idDoctor == historia.cita.idDoctor).FirstOrDefault();
            ViewBag.Doctor = doctor;
            ViewBag.Historia = historia;
            ViewBag.Paciente = paciente;
            return View();
        }

        private string CreateHash(string input)
        {
            var sha = SHA256.Create();
            input += configuration.GetValue<string>("Token");
            var hash = sha.ComputeHash(Encoding.Default.GetBytes(input));

            return Convert.ToBase64String(hash);
        }

    }
}