Shader "Unity Shaders Book/HalfLamber"
{
	Properties
	{
		_Diffuse("Diffuse" , Color) = (1,1,1,1)
	}
	SubShader
	{
		Pass
		{
			Tags {"LightMode" = "ForwardBase"}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float3 worldNormal : TEXCOORD0;
				float4 pos : SV_POSITION;
			};


			v2f vert (appdata v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				o.worldNormal = mul(v.normal , (float3x3)_World2Object);
				return o;
			}
			
			fixed4 _Diffuse;
			fixed4 frag (v2f i) : SV_Target
			{

				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;

				fixed3 worldNormal = normalize(i.worldNormal);

				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);

				fixed3 halfLamber = dot(worldNormal , worldLightDir) * 0.5 + 0.5;

				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLamber;

				fixed3 color = ambient + diffuse;

				return fixed4(color , 1);
			}
			ENDCG
		}
	}
}

