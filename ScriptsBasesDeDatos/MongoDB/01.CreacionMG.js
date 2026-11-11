// ============================================================
// FitZone - MongoDB - 01 Creación de colecciones e índices
// Base de datos: fitzone_nosql (2 colecciones)
// ============================================================

use("fitzone_nosql");
 
db.createRole({
  role: "fitzone_app_rw",
  privileges: [
    { resource: { db: "fitzone_nosql", collection: "rutinas_entrenamiento" }, actions: ["find", "insert", "update", "remove"] },
    { resource: { db: "fitzone_nosql", collection: "progreso_fisico" },       actions: ["find", "insert", "update", "remove"] }
  ],
  roles: []
});
 

db.createUser({ user: "fitzone_app", pwd: "CambiarEstaClave2026*", roles: ["fitzone_app_rw"] });
print("Rol fitzone_app_rw y usuario fitzone_app creados.");
 

use("fitzone_nosql");

// Borrar las colecciones si ya existen
db.rutinas_entrenamiento.drop();
db.progreso_fisico.drop();

// ------------------------------------------------------------
// COLECCIÓN 1: rutinas_entrenamiento
// Una rutina = un documento. Dentro lleva la lista de ejercicios.
//
// PATRÓN POLYMORPHIC: los ejercicios tienen forma distinta según
//   el campo "tipo":
// PATRÓN EMBEDDED: los ejercicios van DENTRO
//   de la rutina porque siempre se leen juntos con ella.
// ------------------------------------------------------------
db.createCollection("rutinas_entrenamiento");

db.rutinas_entrenamiento.createIndex({ id_miembro: 1, activa: 1 });
db.rutinas_entrenamiento.createIndex({ id_sede: 1 });
db.rutinas_entrenamiento.createIndex({ "ejercicios.tipo": 1 });

// ------------------------------------------------------------
// COLECCIÓN 2: progreso_fisico
// Una medición = un documento (peso, grasa, medidas).
//
// PATRÓN REFERENCE: un miembro acumula mediciones sin límite, no se guardan dentro de un
//   miembro: cada medición es su propio documento y apunta al miembro con id_miembro
// ------------------------------------------------------------
db.createCollection("progreso_fisico");
db.progreso_fisico.createIndex({ id_miembro: 1, fecha: -1 }); 
db.progreso_fisico.createIndex({ id_sede: 1 });

// Verificación
print("Colecciones creadas: " + db.getCollectionNames());