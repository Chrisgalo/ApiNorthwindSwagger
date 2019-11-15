using ConectarDatos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Xml.Serialization;
using System.Data.Entity;

namespace MiWebApi.Controllers
{
    public class EmployeeController : ApiController
    {
        NorthwindEntities dbContext = new NorthwindEntities();

        [HttpGet]
        public IEnumerable<Employee> Get()
        {
            using (NorthwindEntities usuariosentities = new NorthwindEntities())
            {
                return usuariosentities.Employees.ToList();
            }
        }

        [HttpGet]
        public Employee Get(int id)
        {
            using (NorthwindEntities usuariosentities = new NorthwindEntities())
            {
                return usuariosentities.Employees.FirstOrDefault(e => e.EmployeeID == id);
            }
        }

        [HttpPost]
        public IHttpActionResult AgregaUsuario([FromBody] Employee usu)
        {
            if(ModelState.IsValid)
            {
                dbContext.Employees.Add(usu);
                dbContext.SaveChanges();
                return Ok(usu);
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpPut]
        public IHttpActionResult ActualizaUsuario(int id, [FromBody] Employee usu)
        {
            if(ModelState.IsValid)
            {
                var UsuarioExiste = dbContext.Employees.Count(c => c.EmployeeID == id) > 0;

                if(UsuarioExiste)
                {
                    dbContext.Entry(usu).State = EntityState.Modified;
                    dbContext.SaveChanges();

                    return Ok();

                }
                else
                {
                    return NotFound();
                }
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete]
        public IHttpActionResult EliminarUsuario(int id)
        {
            var usu = dbContext.Employees.Find(id);

            if(usu != null)
            {
                dbContext.Employees.Remove(usu);
                dbContext.SaveChanges();

                return Ok(usu);
            }
            else
            {
                return NotFound();
            }
        }


    }
}
