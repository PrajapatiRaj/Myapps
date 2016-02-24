package com.example.ram.mysql_login;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class Login extends AppCompatActivity implements View.OnClickListener {


     private  Button join,clr;
     private  EditText email,pass;
     private  RequestQueue requestQueue;
     private static final  String url="http://www.fluxtechsolutions.com/suffle/api/login";
     private StringRequest request;





    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        join=(Button)findViewById(R.id.login);
        clr=(Button)findViewById(R.id.cancel);
        email=(EditText)findViewById(R.id.email);
        pass=(EditText)findViewById(R.id.password);



        join.setOnClickListener(this);

    }

    private void login()
    {
        requestQueue=Volley.newRequestQueue(this);

        Toast.makeText(Login.this, "i am call", Toast.LENGTH_LONG).show();



        request = new StringRequest(Request.Method.POST, url,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response)
                    {

                        try {


                            JSONObject jsonObject = new JSONObject(response);

                            String a= jsonObject.getString("successful");

                            if( a.equals("true"))
                            {
                                 openProfile();
                                Toast.makeText(Login.this,"Success"+jsonObject.getString("successful"), Toast.LENGTH_LONG).show();
                            }
                            else
                            {
                                Toast.makeText(Login.this, "erorr", Toast.LENGTH_LONG).show();
                            }


                        } catch (JSONException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }


                    }

                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Toast.makeText(Login.this,error.toString(),Toast.LENGTH_LONG ).show();
                    }
                }){
            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                Map<String,String> map = new HashMap<String,String>();
                map.put("email", email.getText().toString());
                map.put("password",pass.getText().toString());
                return map;
            }
        };

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.add(request);
    }

    private void openProfile()
    {
         Toast.makeText(getApplicationContext()," open profile is call",Toast.LENGTH_LONG).show();

        startActivity( new Intent(Login.this,Welcome.class));
    }


    public void onClick(View v)
    {
        login();
    }
}











