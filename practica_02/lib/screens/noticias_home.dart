import 'package:flutter/material.dart';
import '/screens/detalle_noticia.dart'; // Importa la pantalla de detalles

class NoticiasHomeScreen extends StatelessWidget {
  final List<Map<String, String>> noticias = [
    {
      'titulo':
          'Trágico Accidente en la Carretera Oruro-Potosí Deja Dos Fallecidos',
      'resumen':
          'Un lamentable choque frontal entre un vehículo particular y un camión en la carretera que conecta Oruro y Potosí .',
      'imagen':
          'https://scontent.flpb1-2.fna.fbcdn.net/v/t39.30808-6/494109871_2533202967017331_8423599258672065407_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=f727a1&_nc_ohc=GFUm_ydWdJ0Q7kNvwHXVVp2&_nc_oc=AdmgjbeYIPANvKPx9wSDh8LKpBXIkx85YFbT62icz2TnQ7wSpQ_vYMmn3qFYpbN0R4MJdUXR9xBaN6Hd2ziJk9GP&_nc_zt=23&_nc_ht=scontent.flpb1-2.fna&_nc_gid=hqrtA3lm7ZKJRRgLPnCAGQ&oh=00_AfEk5UDV0aBe_NmwP6fcyaKSHeopO13IXZNkybq0yy_cWA&oe=68159CCA',
      'detalle':
          'Este es el texto completo y detallado de la noticia importante número uno. Aquí se pueden incluir muchos más detalles e información relevante para el lector.',
    },
    {
      'titulo': 'Pronóstico del Tiempo en Potosí',
      'resumen':
          'La ciudad de Potosí experimentará hoy una jornada con cielos mayormente despejados y sol radiante.',
      'imagen':
          'https://scontent.flpb1-2.fna.fbcdn.net/v/t39.30808-6/494147858_2533202997017328_4481838387405047065_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=f727a1&_nc_ohc=KA4cZ4YUDwkQ7kNvwGHBe1C&_nc_oc=AdnNpbJwziVF0NXmOGXzZs54Xftp0H9yoRNQF4RT_iDtGgusaYGEqHUz9Hb_v9FnAy0Ob5DaTe0_s1vWrIJ_CM-c&_nc_zt=23&_nc_ht=scontent.flpb1-2.fna&_nc_gid=COCWUEL3noIQKQ1p81dgvA&oh=00_AfHyeOuncbr9S78c_eJq6E2ymOHuUCQEBJRpfwrmfbTFeA&oe=68158DEC',
      'detalle':
          'El Servicio Nacional de Meteorología e Hidrología (SENAMHI) ha emitido su pronóstico para la ciudad de Potosí para el día de hoy, lunes 28 de abril de 2025. Se anticipa una jornada con condiciones climáticas estables, caracterizada por cielos mayormente despejados y la presencia de sol durante gran parte del día.',
    },
    {
      'titulo': 'Avance Revolucionario en Baterías de Estado Sólido',
      'resumen':
          'Científicos han anunciado un importante avance en la tecnología de baterías de estado sólido.',
      'imagen':
          'https://scontent.flpb1-1.fna.fbcdn.net/v/t39.30808-6/494149511_2533202983683996_5063409192120274339_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=f727a1&_nc_ohc=bJ45UJb3XdcQ7kNvwHwUSK6&_nc_oc=AdmsfrYV5xEi-3CZnJY0Dca4GQWlBm2pCi9YygFNUHjSql6IOgSNV9qkt0ap02IRKDZO-hvIS5VkI6XldjIFWtTO&_nc_zt=23&_nc_ht=scontent.flpb1-1.fna&_nc_gid=f2yvGtn2Wh4noEgvQSh73w&oh=00_AfEQAgOmDzo7VjERulIhA_L83JGm31drGsLzYstTRnZKtg&oe=6815AB38',
      'detalle':
          'Un equipo de investigadores de la Universidad Tecnológica de Delft, en colaboración con la empresa de materiales avanzados SolidPower, ha publicado recientemente los resultados de su innovadora investigación en el campo de las baterías de estado sólido. Su trabajo se centra en el desarrollo de un nuevo tipo de electrolito sólido cerámico que presenta propiedades electroquímicas superiores a los electrolitos líquidos utilizados en las baterías de iones de litio actuales.',
    },
    // Puedes agregar más noticias aquí
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Noticias')),
      body: ListView.builder(
        itemCount: noticias.length,
        itemBuilder: (context, indice) {
          final Map<String, String> noticia = noticias[indice];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: SizedBox(
                width: 80.0,
                height: 80.0,
                child: Image.network(
                  noticia['imagen']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.image_not_supported));
                  },
                ),
              ),
              title: Text(
                noticia['titulo']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                noticia['resumen']!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetalleNoticiaScreen.routeName,
                  arguments: DetalleNoticiaArguments(
                    titulo: noticia['titulo']!,
                    imagen: noticia['imagen']!,
                    detalle: noticia['detalle']!,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
