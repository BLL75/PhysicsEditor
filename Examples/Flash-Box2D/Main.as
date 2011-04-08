﻿package {	import Box2D.Dynamics.Joints.*;	import flash.display.Sprite;	import flash.events.KeyboardEvent;	import flash.events.Event;	import Box2D.Dynamics.*;	import Box2D.Collision.*;	import Box2D.Collision.Shapes.*;	import Box2D.Common.Math.*;	import PhysicsData;	import SpriteBitmap;	public class Main extends Sprite {		public var world:b2World=new b2World(new b2Vec2(0,10.0),true);		public var physicsData:PhysicsData;		public var nextSprite:Number=10;		public function Main():void {			physicsData = new PhysicsData();			debug_draw();			CreateStaticBox(0,420,320,50);			addEventListener(Event.ENTER_FRAME, update, false, 0, true);		}		public function debug_draw():void {			var debug_draw:b2DebugDraw = new b2DebugDraw();			var debug_sprite:Sprite = new Sprite();			addChild(debug_sprite);			debug_draw.SetSprite(debug_sprite);			debug_draw.SetFillAlpha(0.3);			debug_draw.SetDrawScale(physicsData.ptm_ratio);			debug_draw.SetFlags(b2DebugDraw.e_shapeBit);			debug_draw.SetLineThickness(1.0);			world.SetDebugDraw(debug_draw);		}		public function addNewSprites():void {			var items:Array=["hamburger","drink","icecream","icecream2","icecream3"];			nextSprite--;			if (nextSprite<0) {				nextSprite=30;				var name:String=items[Math.floor(Math.random()*items.length)];				var sprite:SpriteBitmap=new SpriteBitmap(name);				var body:b2Body=physicsData.createBody(name,world,b2Body.b2_dynamicBody,sprite);				body.SetPositionAndAngle(new b2Vec2(Math.floor(Math.random()*7),-2), 0);				addChild(sprite);			}		}		public function update(e : Event):void {			world.Step(1 / 30, 10, 10);			world.ClearForces();			world.DrawDebugData();			addNewSprites();			for (var Body:b2Body = world.GetBodyList(); Body; Body = Body.GetNext()) {				if (Body.GetUserData() is Sprite) {					var sprite:Sprite=Body.GetUserData() as Sprite;					sprite.x=Body.GetPosition().x*30;					sprite.y=Body.GetPosition().y*30;					sprite.rotation = Body.GetAngle() * (180/Math.PI);				}			}		}		public function CreateStaticBox(PositionX:Number, PositionY:Number, Width:Number, Height:Number):void {			// Vars used to create the body			var Body:b2Body;			var Box:b2PolygonShape = new b2PolygonShape();			var BodyDef:b2BodyDef = new b2BodyDef();			var FixtureDef:b2FixtureDef = new b2FixtureDef();			// Create box			Box.SetAsBox(Width / physicsData.ptm_ratio, Height / physicsData.ptm_ratio);			BodyDef.userData="static box";			BodyDef.position.Set( PositionX / physicsData.ptm_ratio, PositionY / physicsData.ptm_ratio);			BodyDef.type=b2Body.b2_staticBody;			FixtureDef.shape=Box;			Body=world.CreateBody(BodyDef);			Body.CreateFixture(FixtureDef);		}	}}