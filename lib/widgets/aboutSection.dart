
import"package:flutter/material.dart";
 Widget buildSection(String title,Widget stars, Color color, String percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 5,),
        stars,
       
        ],
        ),
        
       SizedBox(height: 6,),
        Divider(
          color: color,
          thickness: 20,
        ),
         SizedBox(height: 6,),
      
          Text(
          percentage,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
         
        
          SizedBox(height: 16),
      ],
    );
  }

