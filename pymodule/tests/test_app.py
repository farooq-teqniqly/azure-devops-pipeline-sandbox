from unittest import TestCase
from contoso.app import App

class AppTests(TestCase):
  def test_create_instance(self):
    app = App()
    self.assertEqual("bar", app.foo)